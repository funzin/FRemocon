// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLI",
    dependencies: [
        .package(url: "https://github.com/apple/swift-format", from: "0.50300.0"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.43.1"),
        .package(url: "https://github.com/yonaskolb/XcodeGen", from: "2.19.0")
    ]
)
