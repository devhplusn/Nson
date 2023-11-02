import Foundation

struct Wrapped<Value> {
    
    let value: Value
    
    init(_ value: Value) {
        self.value = value
    }
}

extension Wrapped: Decodable where Value: Decodable {
    
    init(from decoder: Decoder) throws {
        self.value = try Value(from: _NSONDecoder(decoder: decoder))
    }
}

extension Wrapped: Encodable where Value: Encodable {
    
    func encode(to encoder: Encoder) throws {
        try value.encode(to: _NSONEncoder(encoder: encoder))
    }
}
