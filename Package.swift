// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FelixFelicis",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "FelixFelicis",
            targets: ["FelixFelicis"]),
    ],
    targets: [
        .target(
            name: "FelixFelicis",
            dependencies: []),
        .testTarget(
            name: "FelixFelicisTests",
            dependencies: ["FelixFelicis"]),
    ]
)
