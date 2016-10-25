//
//  DropletExtension.swift
//  VaporS3Signer
//
//  Created by Justin M. on 10/25/16.
//
//

import Foundation
import S3SignerAWS
import Vapor

extension Droplet {
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
