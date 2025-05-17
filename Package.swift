// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GraphiQLVapor",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "GraphiQLVapor", targets: ["GraphiQLVapor"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/vapor/vapor.git", from: "4.110.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "GraphiQLVapor",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
            ]),
        .testTarget(name: "GraphiQLVaporTests", dependencies: [
            .product(name: "VaporTesting", package: "vapor"),
            "GraphiQLVapor",
        ]),
    ]
)
