import Vapor
import S3SignerAWS
import HTTP

public final class Provider: Vapor.Provider {
 
	private static let configFileName: String = "vapor-S3Signer"
	public static let repositoryName: String = "vapor-S3Signer"
	
	public var s3Signer: S3SignerAWS
	
	public init(accessKey: String, secretKey: String, region: Region, securityToken: String? = nil) {
		self.s3Signer = S3SignerAWS(accessKey: accessKey, secretKey: secretKey, region: region, securityToken: securityToken)
	}
	
	public convenience init(config: Config) throws {
		
		guard config[Provider.configFileName] != nil else {
			throw S3ProviderError.config("no vapor-S3Signer.json config file")
		}
		
		guard let accessKey = config[Provider.configFileName, "accessKey"]?.string else {
			throw S3ProviderError.config("No 'accessKey' key in vapor-S3Signer.json config file.")
		}
		
		guard let secretKey = config[Provider.configFileName, "secretKey"]?.string else {
			throw S3ProviderError.config("No 'secretKey' key in vapor-S3Signer.json config file.")
		}
		
		guard let region = config[Provider.configFileName, "region"]?.string else {
			throw S3ProviderError.config("No 'region' key in vapor-S3Signer.json config file.")
		}
		
		guard let regionEnum = Region(rawValue: region) else {
			throw S3ProviderError.config("region name does not conform to any Region raw values. Check Region.swift for proper names.")
		}
		
		let token = config[Provider.configFileName, "securityToken"]?.string
		
		self.init(accessKey: accessKey, secretKey: secretKey, region: regionEnum, securityToken: token)
	}
	
	public func beforeRun(_ droplet: Droplet) throws { }
	
	public func boot(_ config: Config) throws { }
	
	public func boot(_ droplet: Droplet) throws {
		droplet.storage["s3Signer"] = self.s3Signer
	}
	
	public enum S3ProviderError: Swift.Error {
		case config(String)
	}
}









