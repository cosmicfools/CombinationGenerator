// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "CombinationGenerator",
    products: [
        .library(
            name: "CombinationGenerator",
            targets: ["CombinationGenerator"]),
    ],
    dependencies: [
        .package(name: "Runtime", url: "https://github.com/wickwirew/Runtime.git", from: "2.2.4")
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
