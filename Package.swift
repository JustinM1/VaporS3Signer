import PackageDescription

let package = Package(
    name: "VaporS3Signer",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/JustinM1/S3SignerAWS.git",
                 majorVersion: 2),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2)
    ]
)
