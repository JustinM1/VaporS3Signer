import Vapor
import HTTP

extension Dictionary where Key == String, Value == String {
	
	var vaporHeaders: [HeaderKey: String] {
		var newHeaders: [HeaderKey: String] = [:]
		self.forEach { newHeaders.updateValue($0.value, forKey: HeaderKey($0.key)) }
		return newHeaders
	}
}
