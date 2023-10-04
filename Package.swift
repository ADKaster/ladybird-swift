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
