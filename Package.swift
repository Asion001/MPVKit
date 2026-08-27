// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "MPVKit",
    platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15), .visionOS(.v1)],
    products: [
        .library(
            name: "MPVKit",
            targets: ["_MPVKit"]
        ),
        .library(
            name: "MPVKit-GPL",
            targets: ["_MPVKit-GPL"]
        ),
    ],
    targets: [
        .target(
            name: "_MPVKit",
            dependencies: [
                "Libmpv", "_FFmpeg", "Libuchardet", "Libbluray",
                .target(name: "Libluajit", condition: .when(platforms: [.macOS])),
            ],
            path: "Sources/_MPVKit",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreAudio"),
            ]
        ),
        .target(
            name: "_FFmpeg",
            dependencies: [
                "Libavcodec", "Libavdevice", "Libavfilter", "Libavformat", "Libavutil", "Libswresample", "Libswscale",
                "Libssl", "Libcrypto", "Libass", "Libfreetype", "Libfribidi", "Libharfbuzz",
                "MoltenVK", "Libshaderc_combined", "lcms2", "Libplacebo", "Libdovi", "Libunibreak",
                "gmp", "nettle", "hogweed", "gnutls", "Libdav1d", "Libuavs3d"
            ],
            path: "Sources/_FFmpeg",
            linkerSettings: [
                .linkedFramework("AudioToolbox"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("Metal"),
                .linkedFramework("VideoToolbox"),
                .linkedLibrary("bz2"),
                .linkedLibrary("iconv"),
                .linkedLibrary("expat"),
                .linkedLibrary("resolv"),
                .linkedLibrary("xml2"),
                .linkedLibrary("z"),
                .linkedLibrary("c++"),
            ]
        ),
        .target(
            name: "_MPVKit-GPL",
            dependencies: [
                "Libmpv-GPL", "_FFmpeg-GPL", "Libuchardet", "Libbluray",
                .target(name: "Libluajit", condition: .when(platforms: [.macOS])),
            ],
            path: "Sources/_MPVKit-GPL",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreAudio"),
            ]
        ),
        .target(
            name: "_FFmpeg-GPL",
            dependencies: [
                "Libavcodec-GPL", "Libavdevice-GPL", "Libavfilter-GPL", "Libavformat-GPL", "Libavutil-GPL", "Libswresample-GPL", "Libswscale-GPL",
                "Libssl", "Libcrypto", "Libass", "Libfreetype", "Libfribidi", "Libharfbuzz",
                "MoltenVK", "Libshaderc_combined", "lcms2", "Libplacebo", "Libdovi", "Libunibreak",
                "Libsmbclient", "gmp", "nettle", "hogweed", "gnutls", "Libdav1d", "Libuavs3d"
            ],
            path: "Sources/_FFmpeg-GPL",
            linkerSettings: [
                .linkedFramework("AudioToolbox"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("Metal"),
                .linkedFramework("VideoToolbox"),
                .linkedLibrary("bz2"),
                .linkedLibrary("iconv"),
                .linkedLibrary("expat"),
                .linkedLibrary("resolv"),
                .linkedLibrary("xml2"),
                .linkedLibrary("z"),
                .linkedLibrary("c++"),
            ]
        ),

        .binaryTarget(
            name: "Libmpv-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libmpv-GPL.xcframework.zip",
            checksum: "45989efd473c9a2295a3d1d0da0bcd004d14f0eeea81bda671be89c78f3925ff"
        ),
        .binaryTarget(
            name: "Libavcodec-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libavcodec-GPL.xcframework.zip",
            checksum: "8df07384ace5bd48520669db89203e51cc13ce99a6d0bef975a83a45e5ea5855"
        ),
        .binaryTarget(
            name: "Libavdevice-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libavdevice-GPL.xcframework.zip",
            checksum: "14f3bfc950548eeb0d0686f9ddc2fb7ea120def036767c1490d2731df6e91f65"
        ),
        .binaryTarget(
            name: "Libavformat-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libavformat-GPL.xcframework.zip",
            checksum: "90281cdac29184fb618dc8ab6e091faa05b471efbd0b9a1c1a67c235b6961483"
        ),
        .binaryTarget(
            name: "Libavfilter-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libavfilter-GPL.xcframework.zip",
            checksum: "f9789661088275acac3d84e545beb5def04407418b73283994b6863c4db1582e"
        ),
        .binaryTarget(
            name: "Libavutil-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libavutil-GPL.xcframework.zip",
            checksum: "32849241cf71e949b4718dfdb1b69ece0f1ca9cb9d89b84a35051686b6bafbd0"
        ),
        .binaryTarget(
            name: "Libswresample-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libswresample-GPL.xcframework.zip",
            checksum: "f59191f210476e24a53a18a3b55158b82c5f685d19f2fb29582d95f5c3dff4eb"
        ),
        .binaryTarget(
            name: "Libswscale-GPL",
            url: "https://github.com/mpvkit/MPVKit/releases/download/1.0.0/Libswscale-GPL.xcframework.zip",
            checksum: "1eb1cc2d67e933837be7e5937e440b6dcf0000fd799b96e212dd2c14c5fe2d62"
        ),
        //AUTO_GENERATE_TARGETS_BEGIN//

        .binaryTarget(
            name: "Libcrypto",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libcrypto.xcframework.zip",
            checksum: "6fe3b6716ea0a7118bf326ca40bdcabb0d52b47364d070948181824cca40e67c"
        ),
        .binaryTarget(
            name: "Libssl",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libssl.xcframework.zip",
            checksum: "beaccc9f3bf50a36d3671ad4a73c94825bb0b8d2e427bba6b355ae04fe2ae2ab"
        ),

        .binaryTarget(
            name: "gmp",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/gmp.xcframework.zip",
            checksum: "afc988ab3bfb1186fe08b8e0347ffebdfefd404b4c0dc527a008614568c259b9"
        ),

        .binaryTarget(
            name: "nettle",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/nettle.xcframework.zip",
            checksum: "9a415c73d4e5a1917e6374bfe441f9f2339d9b9b3585163423a760548f9d9b2d"
        ),
        .binaryTarget(
            name: "hogweed",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/hogweed.xcframework.zip",
            checksum: "d61de7c69d1b1bc233525971aa45f35fe45e75e6e0d5d4945665618286215bec"
        ),

        .binaryTarget(
            name: "gnutls",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/gnutls.xcframework.zip",
            checksum: "f6bfb16dfde5d2174d5d010b986d0df77d4fec21e089c2f9ab3f3853064c45b6"
        ),

        .binaryTarget(
            name: "Libunibreak",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libunibreak.xcframework.zip",
            checksum: "d50fc5ac4c37760341e4e152dfc337d907ee921248bae497360b7907b712c195"
        ),

        .binaryTarget(
            name: "Libfreetype",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libfreetype.xcframework.zip",
            checksum: "18453053896119036237a910e83c5d8d5ae9e737ec4d4402da5bd47d19833f7b"
        ),

        .binaryTarget(
            name: "Libfribidi",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libfribidi.xcframework.zip",
            checksum: "c1ac70b33945a9cecae4cc38ca86e9844ab9ea779e9c13f5987f39d25232601e"
        ),

        .binaryTarget(
            name: "Libharfbuzz",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libharfbuzz.xcframework.zip",
            checksum: "f0625945bee6bdf619e2e177cfe2ef717d6b1d139bc930674b676d8c2bb78612"
        ),

        .binaryTarget(
            name: "Libass",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libass.xcframework.zip",
            checksum: "d165e6875163e44cf507c6013394d3501b3f9152942df8a47b03b87d654e9d45"
        ),

        .binaryTarget(
            name: "Libsmbclient",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libsmbclient.xcframework.zip",
            checksum: "181726cce98cf5dcc9b6ed795c18520738c92dc8cb3b1b0385124b26ceca391a"
        ),

        .binaryTarget(
            name: "Libbluray",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libbluray.xcframework.zip",
            checksum: "384401bafe50f562ad19d9c69d51527fb0f46b46f16770ebac948a2cd0e7c6cc"
        ),

        .binaryTarget(
            name: "Libuavs3d",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libuavs3d.xcframework.zip",
            checksum: "93f35c93fd39611fb791f0b7fe0206c6acffdc64e7d699989c58132e5ce4b2db"
        ),

        .binaryTarget(
            name: "Libdovi",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libdovi.xcframework.zip",
            checksum: "ce69380992cacf42161fa78a24aa6cccf8774576b3a4b01668ae7820bed07ff0"
        ),

        .binaryTarget(
            name: "MoltenVK",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/MoltenVK.xcframework.zip",
            checksum: "aee189c54ad7c62bf734a3dc51eb4cfad5685d1d63b0ec519ecd1b437c332418"
        ),

        .binaryTarget(
            name: "Libshaderc_combined",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libshaderc_combined.xcframework.zip",
            checksum: "165fdcb7a828689498a47002285f9fd7283a64b8073d1fd47ca479741cc19b38"
        ),

        .binaryTarget(
            name: "lcms2",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/lcms2.xcframework.zip",
            checksum: "c08258d8f1f3708e02d052ca6e83cce4b501d782a014e663f6c0e6bbd165dfcd"
        ),

        .binaryTarget(
            name: "Libplacebo",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libplacebo.xcframework.zip",
            checksum: "2c633f93c326cb8dfe36904ae5944fb1d1be7732f04ce01b41618c1f1c546ca6"
        ),

        .binaryTarget(
            name: "Libdav1d",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libdav1d.xcframework.zip",
            checksum: "59059d042ede9a1b8bd02f2ca4f145d98748187c720f7058ebbe204f3ad99a39"
        ),

        .binaryTarget(
            name: "Libavcodec",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libavcodec.xcframework.zip",
            checksum: "3a95dc4b0bad0807ba3a1e73dce607eff0f684dd45d6f61bb24aef5d67fc07a2"
        ),
        .binaryTarget(
            name: "Libavdevice",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libavdevice.xcframework.zip",
            checksum: "eb4671338e71d64ec452754d6617680a47df12f7b52f61cb99b640d2db34212d"
        ),
        .binaryTarget(
            name: "Libavformat",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libavformat.xcframework.zip",
            checksum: "92c75148a3f0bb31a1a63fcf080a48540d4a2acd5a4f08a752c3b068e2f82f4a"
        ),
        .binaryTarget(
            name: "Libavfilter",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libavfilter.xcframework.zip",
            checksum: "83b07d0477f2e3afa14be0f097b96a73d90e2873e1ca6be107a2d4f98a2ac59e"
        ),
        .binaryTarget(
            name: "Libavutil",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libavutil.xcframework.zip",
            checksum: "038b6ebc8b6f2b3164bdbca8864a8597a4b149e00d7ba9547b14488fb4d6ab1f"
        ),
        .binaryTarget(
            name: "Libswresample",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libswresample.xcframework.zip",
            checksum: "57465ddc1fe5f245bd8962fbb4dd6d35c741aef239e98eb86f382d16f9786273"
        ),
        .binaryTarget(
            name: "Libswscale",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libswscale.xcframework.zip",
            checksum: "7dd021bd1d4a46bf5ed90c6ae147f5d7addf397e37694059fdc36d38538241dd"
        ),

        .binaryTarget(
            name: "Libuchardet",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libuchardet.xcframework.zip",
            checksum: "ea4bbd1a1215244e355a686429ef30a7648b9d1a5b1765265bfab78f09849792"
        ),

        .binaryTarget(
            name: "Libluajit",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libluajit.xcframework.zip",
            checksum: "3a171ef1627fb88260893dc452f989bd93dd8510814771ba3aff7753470d3f3e"
        ),

        .binaryTarget(
            name: "Libmpv",
            url: "https://github.com/Asion001/MPVKit/releases/download/1.0.0-swiftfin.3/Libmpv.xcframework.zip",
            checksum: "c0d9d2f1303441bb3333a50858db6bf8de70907931cd456b24a8344a2d3508f7"
        ),
        //AUTO_GENERATE_TARGETS_END//
    ]
)
