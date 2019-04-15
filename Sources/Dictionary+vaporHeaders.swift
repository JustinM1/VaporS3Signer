import Vapor
import HTTP

extension Dictionary where Key == String, Value == String {
	
	public var vaporHeaders: HTTPHeaders {
        return HTTPHeaders.init(self.map { ($0.key, $0.value) })
	}
}
