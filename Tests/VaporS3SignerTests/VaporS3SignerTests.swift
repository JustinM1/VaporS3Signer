import HTTP
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
	
	func testVaporHeaders() {
		let headers: [String: String] = [
			"headerKey1": "headerValue1",
			"headerKey2": "headerValue2"
		]
		
		let expectedHeaders: [HeaderKey: String] = [
			HeaderKey("headerKey1"): "headerValue1",
			HeaderKey("headerKey2"): "headerValue2"
		]
		
		XCTAssertEqual(headers.vaporHeaders, expectedHeaders)
	}
}
