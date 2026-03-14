// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HaploUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "HaploUI",
            targets: ["HaploUI"]
        ),
    ],
    targets: [
        .target(
            name: "HaploUI",
            dependencies: [],
            path: "Sources/HaploUI",
            resources: [
                .process("Resources"),
                .process("Shaders")
            ]
        ),
        .testTarget(
            name: "HaploUITests",
            dependencies: ["HaploUI"]
        ),
    ]
)
