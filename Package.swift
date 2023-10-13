// swift-tools-version:5.9

import PackageDescription

let SwiftTest =
  Package(
    name: "SwiftTest",
    platforms: [
      .macOS(.v13)
    ],
    products: [
      .executable(name: "View", targets: ["View"])
    ],
    targets: [
      .target(
        name: "lagom",
        publicHeadersPath: "include",
        cSettings: [
          .headerSearchPath("../../third_party/lagom/include"),
          .headerSearchPath("../../third_party/lagom/include/Services"),
          .headerSearchPath("../../third_party/lagom/include/Userland/Libraries"),
          .headerSearchPath("../../third_party/lagom/include/Userland/Services"),
        ],
        cxxSettings: [
          .define("__swift__")
        ],
        linkerSettings: [
             .unsafeFlags([
                "-Lthird_party/lagom/lib",
            ]),
            .linkedLibrary("lagom-audio"),
            .linkedLibrary("lagom-compress"),
            .linkedLibrary("lagom-core"),
            .linkedLibrary("lagom-crypto"),
            .linkedLibrary("lagom-filesystem"),
            .linkedLibrary("lagom-gemini"),
            .linkedLibrary("lagom-gfx"),
            .linkedLibrary("lagom-gl"),
            .linkedLibrary("lagom-glsl"),
            .linkedLibrary("lagom-gpu"),
            .linkedLibrary("lagom-gui"),
            .linkedLibrary("lagom-http"),
            .linkedLibrary("lagom-idl"),
            .linkedLibrary("lagom-ipc"),
            .linkedLibrary("lagom-js"),
            .linkedLibrary("lagom-locale"),
            .linkedLibrary("lagom-markdown"),
            .linkedLibrary("lagom-protocol"),
            .linkedLibrary("lagom-regex"),
            .linkedLibrary("lagom-softgpu"),
            .linkedLibrary("lagom-sql"),
            .linkedLibrary("lagom-syntax"),
            .linkedLibrary("lagom-textcodec"),
            .linkedLibrary("lagom-threading"),
            .linkedLibrary("lagom-tls"),
            .linkedLibrary("lagom-unicode"),
            .linkedLibrary("lagom-video"),
            .linkedLibrary("lagom-wasm"),
            .linkedLibrary("lagom-web"),
            .linkedLibrary("lagom-webview"),
            .linkedLibrary("lagom-xml"),
        ]),
      .executableTarget(
        name: "View",
        dependencies: [
          "lagom"
        ],
        resources: [
            .copy("Resources"),
        ],
        packageAccess: false,
        cxxSettings: [
          .headerSearchPath("../../third_party/lagom/include"),
          .headerSearchPath("../../third_party/lagom/include/Services"),
          .headerSearchPath("../../third_party/lagom/include/Userland/Libraries"),
          .headerSearchPath("../../third_party/lagom/include/Userland/Services"),
        ],
        swiftSettings: [
          .interoperabilityMode(.Cxx)
        ]),
    ],
    cxxLanguageStandard: .cxx20)
