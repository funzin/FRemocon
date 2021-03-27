// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FRemocon",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10)],
    products: [
        .library(
            name: "FRemocon",
            targets: ["FRemocon"]),
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "7.0.0")),
    ],
    targets: [
        .target(
            name: "FRemocon",
            dependencies: [
                .product(name: "FirebaseRemoteConfig", package: "Firebase"),
            ]),
        .testTarget(
            name: "FRemoconTests",
            dependencies: ["FRemocon"],
            resources: [.process("Resources")]),
    ]
)
