// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Coordinator",
    products: [
        .library(
            name: "Coordinator",
            targets: ["Coordinator"])
    ],
    targets: [
        .target(
            name: "Coordinator",
            dependencies: []
        ),
        .testTarget(
            name: "CoordinatorTests",
            dependencies: ["Coordinator"])
    ],
    swiftLanguageVersions: [.v5]
)
