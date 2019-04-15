// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "VaporS3Signer",
    products: [
        .library(name: "VaporS3Signer", targets: ["VaporS3Signer"])
    ],
    dependencies: [
        .package(url: "https://github.com/JustinM1/S3SignerAWS.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMinor(from: "3.3.0"))
    ],
    targets: [
        .target(name: "VaporS3Signer", dependencies: ["S3SignerAWS", "Vapor"], path: "Sources"),
        .testTarget(name: "VaporS3SignerTests", dependencies: ["VaporS3Signer"])
    ]
)
