// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftKeeper",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftKeeper",
            targets: ["SwiftKeeper"]),
    ],
    targets: [
        .target(
            name: "SwiftKeeper"),
        .testTarget(
            name: "SwiftKeeperTests",
            dependencies: ["SwiftKeeper"]),
    ]
)
