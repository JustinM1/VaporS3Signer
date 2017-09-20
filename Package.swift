import PackageDescription

let package = Package(
    name: "VaporS3Signer",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/JustinM1/S3SignerAWS.git",
                 majorVersion: 3),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2)
    ]
)
