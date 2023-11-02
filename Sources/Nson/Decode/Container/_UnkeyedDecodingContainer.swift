import Foundation

struct _UnkeyedDecodingContainer: UnkeyedDecodingContainer {
    
    private let decoder: _NSONDecoder
    private var container: UnkeyedDecodingContainer
    
    init(decoder: _NSONDecoder) throws {
        self.decoder = decoder
        self.container = try decoder.decoder.unkeyedContainer()
    }
    
    var codingPath: [CodingKey] {
        self.decoder.codingPath
    }
    
    var count: Int? {
        self.container.currentIndex
    }
    
    var isAtEnd: Bool {
        self.container.isAtEnd
    }
    
    var currentIndex: Int {
        self.container.currentIndex
    }
    
    mutating func decodeNil() throws -> Bool {
        try self.container.decodeNil()
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        try self.container.decode(type)
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        try self.container.decode(type)
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        try T(from: superDecoder())
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        try KeyedDecodingContainer(_KeyedDecodingContainer<NestedKey>(decoder: superDecoder() as! _NSONDecoder))
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        try _UnkeyedDecodingContainer(decoder: superDecoder() as! _NSONDecoder)
    }
    
    mutating func superDecoder() throws -> Decoder {
        try _NSONDecoder(decoder: container.superDecoder())
    }
}
