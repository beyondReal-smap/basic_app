// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ZeroApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "ZeroApp", targets: ["ZeroApp"])
    ],
    targets: [
        .target(
            name: "ZeroApp",
            path: "Sources"
        )
    ]
)
