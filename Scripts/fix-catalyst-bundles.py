#!/usr/bin/env python3
"""Rewrites Mac Catalyst framework slices into versioned bundles.

MPVKit builds every slice as a shallow bundle with Info.plist at the root. That
is valid on iOS, but Xcode refuses to embed a shallow framework into a Mac
Catalyst app: it wants Versions/Current/Resources/Info.plist. Embedding the
unmodified xcframeworks fails at the validation step with

    contains Info.plist, expected Versions/Current/Resources/Info.plist
    since the platform does not use shallow bundles

Run this over dist/release after a build, before uploading the artifacts.
"""
import hashlib
import os
import pathlib
import shutil
import subprocess
import sys
import tempfile


def to_versioned(framework: pathlib.Path) -> bool:
    if (framework / "Versions").exists():
        return False

    name = framework.name.removesuffix(".framework")
    versions = framework / "Versions" / "A"
    versions.mkdir(parents=True)

    for item in list(framework.iterdir()):
        if item.name == "Versions":
            continue
        if item.name == "Info.plist":
            resources = versions / "Resources"
            resources.mkdir(parents=True, exist_ok=True)
            shutil.move(str(item), str(resources / "Info.plist"))
        else:
            shutil.move(str(item), str(versions / item.name))

    os.symlink("A", framework / "Versions" / "Current")
    for link in (name, "Resources", "Headers", "Modules"):
        if (versions / link).exists():
            os.symlink(f"Versions/Current/{link}", framework / link)
    return True


def repackage(zip_path: pathlib.Path) -> bool:
    # zip runs with cwd set to the staging directory, so the destination has to
    # be absolute or it would be written inside that directory instead.
    zip_path = zip_path.resolve()
    with tempfile.TemporaryDirectory() as tmp:
        work = pathlib.Path(tmp)
        subprocess.run(["unzip", "-q", str(zip_path), "-d", str(work)], check=True)

        bundles = list(work.glob("*.xcframework"))
        if len(bundles) != 1:
            raise SystemExit(f"{zip_path.name}: expected one xcframework, found {len(bundles)}")

        changed = any(
            to_versioned(framework)
            for framework in bundles[0].glob("*maccatalyst*/*.framework")
        )
        if not changed:
            return False

        zip_path.unlink()
        # -y stores symlinks as symlinks instead of following them, and the
        # bundle is named explicitly so no "./" prefix enters the archive.
        subprocess.run(
            ["zip", "-qry", str(zip_path), bundles[0].name],
            cwd=work,
            check=True,
        )
        return True


def main(release_dir: str) -> None:
    directory = pathlib.Path(release_dir)
    for zip_path in sorted(directory.glob("*.xcframework.zip")):
        changed = repackage(zip_path)
        digest = hashlib.sha256(zip_path.read_bytes()).hexdigest()
        checksum = directory / (zip_path.name.removesuffix(".zip") + ".checksum.txt")
        checksum.write_text(digest + "\n")
        print(f"{'repacked ' if changed else 'unchanged'} {zip_path.name:<44} {digest}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "dist/release")
