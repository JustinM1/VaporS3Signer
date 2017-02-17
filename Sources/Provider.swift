import Vapor
import S3SignerAWS
import HTTP


public final class Provider: Vapor.Provider {
    
    public var s3Signer: S3SignerAWS
    
    public init(accessKey: String, secretKey: String, region: Region, securityToken: String? = nil) {
        self.s3Signer = S3SignerAWS(accessKey: accessKey, secretKey: secretKey, region: region, securityToken: securityToken)
    }
    
    public convenience init(config: Config) throws {
        guard let vaporS3 = config["vapor-S3Signer"]?.object else {
            throw S3ProviderError.config("no vapor-S3Signer.json config file")
        }
        guard let accessKey = vaporS3["accessKey"]?.string else {
            throw S3ProviderError.config("No 'accessKey' key in vapor-S3Signer.json config file.")
        }
        
        guard let secretKey = vaporS3["secretKey"]?.string else {
            throw S3ProviderError.config("No 'secretKey' key in vapor-S3Signer.json config file.")
        }
        
        guard let region = vaporS3["region"]?.string else {
            throw S3ProviderError.config("No 'region' key in vapor-S3Signer.json config file.")
        }
        
        guard let regionEnum = Region(rawValue: region) else {
            throw S3ProviderError.config("region name does not conform to any Region raw values. Check Region.swift for proper names.")
        }

        let token = vaporS3["securityToken"]?.string
        
        self.init(accessKey: accessKey, secretKey: secretKey, region: regionEnum, securityToken: token)

    }
    
    public func beforeRun(_: Droplet) {
        
    }
    
    public func afterInit(_ drop: Droplet) {
        drop.storage["s3Signer"] = self.s3Signer
    }
    
    public enum S3ProviderError: Swift.Error {
        case config(String)
    }
}









