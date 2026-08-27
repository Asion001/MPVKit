# Swiftfin Enhanced fork of MPVKit

This fork exists for one reason: to build libmpv with a MetalFX spatial upscaling pass inside
`vo_gpu_next`, which stock libmpv does not have.

## What differs from upstream

- `Sources/BuildScripts/patch/libmpv/0004-metalfx-upscaling.patch` — the MetalFX pass.
- `Package.swift` — the `Libmpv` binary target points at this fork's releases. Every other binary
  target still points at upstream `mpvkit`, so only libmpv is rebuilt here.
- Upstream's GitHub workflows are removed. Builds are produced locally and uploaded to this fork's
  releases; nothing builds automatically on push.

## What the patch does

`vo_gpu_next` normally renders video and composites subtitles and OSD into the swapchain in one
`pl_render_image_mix` call. With `--metalfx=yes` and a source smaller than the display, it instead:

1. renders the video alone into an intermediate texture at source resolution, with no overlays,
2. runs `MTLFXSpatialScaler` to scale that texture up to display resolution,
3. composites the upscaled video *and* the overlays onto the swapchain.

Subtitles are therefore drawn after the upscale, at native resolution, instead of being scaled up
with the video.

The intermediate textures are `MTLTexture`s imported into libplacebo through
`PL_HANDLE_MTL_TEX`, the same mechanism mpv's VideoToolbox hwdec already uses, so no copy happens
between the render pass and the upscaler.

### Options

| Option | Default | Meaning |
|---|---|---|
| `--metalfx` | `no` | Enable the MetalFX pass |
| `--metalfx-sharpness` | `0` | Reserved for future sharpening control, `0`–`1` |
| `--metalfx-max-source-height` | `0` | Skip MetalFX above this source height; `0` means no limit |

### Known cost

libplacebo renders over MoltenVK's command queue while MetalFX runs on its own, and the two share
no timeline. The pass therefore calls `pl_gpu_finish()` and waits for the MetalFX command buffer,
which serializes the GPU once per frame. Replacing that with an external semaphore
(`pl_vulkan_hold_ex` / `pl_vulkan_release_ex`) is the obvious next optimization.

## Why this fork hosts every framework

Upstream MPVKit builds every framework slice as a shallow bundle, with `Info.plist` at the bundle
root. That is correct for iOS, but Xcode refuses to embed a shallow framework into a Mac Catalyst
app:

```
Framework ... contains Info.plist, expected Versions/Current/Resources/Info.plist
since the platform does not use shallow bundles
```

Every embedded framework hits this, not just libmpv, so the fork re-hosts all 30 non-GPL binary
targets with their Mac Catalyst slices converted to versioned bundles by
`Scripts/fix-catalyst-bundles.py`. The GPL variants are unused by Swiftfin and still point at
upstream.

Only libmpv and FFmpeg are rebuilt from source here; the rest are upstream artifacts that are
downloaded, repackaged, and re-uploaded unchanged apart from the Catalyst bundle layout. The
`tvos` and `xros` slices are passed through as upstream built them.

## Consuming the framework

`MetalFX.framework` is absent from the simulator SDKs, so the simulator slices are built with
`-Dmetalfx=disabled` and the framework is **not** declared in `Package.swift` — SwiftPM cannot
express "device but not simulator". Apps linking the device or Mac Catalyst slices must add it
themselves, for example:

```
OTHER_LDFLAGS[sdk=iphoneos*] = -framework MetalFX
OTHER_LDFLAGS[sdk=macosx*]   = -framework MetalFX
```

## Building

```
make build platform=macos                          # desktop mpv binary for testing
./mpv.sh --metalfx=yes --vo=gpu-next <file>

make build platform=ios,isimulator,maccatalyst     # the xcframeworks Swiftfin consumes
```

Only libmpv and FFmpeg build from source; everything else downloads prebuilt from upstream
`mpvkit`. FFmpeg's build needs `nasm`.

After a build, zip `dist/release/Libmpv.xcframework`, upload it to a release on this fork, and
update the `Libmpv` binary target's URL and checksum in `Package.swift`
(`swift package compute-checksum`).

## Licensing

libmpv is LGPL, and this fork modifies it. The modified source must stay publicly available, which
is what this repository provides. Swiftfin links the non-GPL `MPVKit` product; `MPVKit-GPL` would
place the app under the GPL.
