import XCTest
import Vapor

@testable import VaporS3Signer

class VaporS3SignerTests: XCTestCase {
    func testDropletExtension() {
        let drop = Droplet()
        drop.addProvider(VaporS3Signer.Provider(accessKey: "access", secretKey: "secret", region: .usWest1, securityToken: "token"))
        if let signer = drop.s3Signer {
            XCTAssert(signer.region == .usWest1)
        } else {
            XCTAssert(false)
        }
    }

    static var allTests : [(String, (VaporS3SignerTests) -> () throws -> Void)] {
        return [
            ("testDropletExtension", testDropletExtension)
        ]
    }
}
