import Foundation
import S3SignerAWS
import Vapor

extension Droplet {
	
    /// Access currently stored S3Signer.
    public var s3Signer: S3SignerAWS? {
        get {
            return self.storage["s3Signer"] as? S3SignerAWS
        }
        set {
            if let val = newValue {
                self.storage["s3Signer"] = val
            }
        }
    }
}
