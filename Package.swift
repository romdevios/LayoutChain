// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "LayoutChain",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "LayoutChain",
            targets: ["LayoutChain"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LayoutChain",
            dependencies: []
        ),
        .testTarget(
            name: "LayoutChainTests",
            dependencies: ["LayoutChain"]
        ),
    ]
)
