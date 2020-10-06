// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombinationGenerator",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CombinationGenerator",
            targets: ["CombinationGenerator"]),
    ],
    dependencies: [
        .package(name: "Runtime", url: "https://github.com/wickwirew/Runtime.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "CombinationGenerator",
            dependencies: ["Runtime"]),
        .testTarget(
            name: "CombinationGeneratorTests",
            dependencies: ["CombinationGenerator"]),
    ]
)
