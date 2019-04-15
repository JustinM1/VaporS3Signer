import Vapor
import S3SignerAWS
import HTTP

public struct VaporS3SignerConfig: Service {

    enum ConfigError: Error {
        case invalidRegion
    }

    public let accessKey: String
    public let secretKey: String
    public let region: Region
    public let securityToken: String?

    public init(accessKey: String, secretKey: String, region: String, securityToken: String?) throws {
        guard let regionEnum = Region(rawValue: region) else {
            throw ConfigError.invalidRegion
        }

        self.accessKey = accessKey
        self.secretKey = secretKey
        self.region = regionEnum
        self.securityToken = securityToken
    }
}

extension S3SignerAWS: Service {}

public final class VaporS3SignerProvider: Provider {
    public func register(_ services: inout Services) throws {
        services.register { container -> S3SignerAWS in
            let config = try container.make(VaporS3SignerConfig.self)
            return S3SignerAWS(accessKey: config.accessKey, secretKey: config.secretKey, region: config.region, securityToken: config.securityToken)
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

extension Container {

    func s3Signer() throws -> S3SignerAWS {
        return try make()
    }
}









