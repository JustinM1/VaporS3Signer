import Vapor
import XCTest
@testable import VaporS3Signer

class VaporS3SignerTests: XCTestCase {
	
	static var allTests : [(String, (VaporS3SignerTests) -> () throws -> Void)] {
		return [
			("testDropletExtension", testDropletExtension)
		]
	}
	
	func testDropletExtension() {
		do {
			let config = try Config()
			
			try config.addProvider(VaporS3Signer.Provider(
				accessKey: "access",
				secretKey: "secret",
				region: .usWest1,
				securityToken: "token"))
			
			let drop = try Droplet(config)
			
			guard let signer = drop.s3Signer else {
				XCTFail("Droplet s3Signer should not be nil.")
				return
			}
			
			XCTAssertEqual(signer.region, .usWest1)

		} catch {
			XCTFail("Error caught during test: \(error)")
		}
    }
}
