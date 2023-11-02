import Foundation

struct _SingleValueDecodingContainer: SingleValueDecodingContainer {
    
    private let decoder: _NSONDecoder
    private let container: SingleValueDecodingContainer
    
    init(decoder: _NSONDecoder) throws {
        self.decoder = decoder
        self.container = try decoder.decoder.singleValueContainer()
    }
    
    var codingPath: [CodingKey] {
        decoder.codingPath
    }
    
    func decodeNil() -> Bool {
        container.decodeNil()
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try container.decode(type)
    }
    
    func decode(_ type: String.Type) throws -> String {
        try container.decode(type)
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try container.decode(type)
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try container.decode(type)
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try container.decode(type)
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        try container.decode(type)
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        try container.decode(type)
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        try container.decode(type)
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        try container.decode(type)
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        try container.decode(type)
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try container.decode(type)
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try container.decode(type)
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try container.decode(type)
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try container.decode(type)
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        try T(from: self.decoder)
    }
}
