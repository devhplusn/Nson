// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Nson",
    platforms:[
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "Nson",
            targets: ["Nson"]),
    ],
    targets: [
        .target(
            name: "Nson",
            dependencies: []),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
