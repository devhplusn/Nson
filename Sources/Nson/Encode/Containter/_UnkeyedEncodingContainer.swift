import Foundation

struct _UnkeyedEncodingContainer: UnkeyedEncodingContainer {
    
    private let encoder: _NSONEncoder
    private var container: UnkeyedEncodingContainer
    
    init(encoder: _NSONEncoder) {
        self.encoder = encoder
        self.container = encoder.encoder.unkeyedContainer()
    }
    
    var codingPath: [CodingKey] {
        encoder.codingPath
    }
    
    var count: Int {
        container.count
    }
    
    mutating func encodeNil() throws {
        try container.encodeNil()
    }
    
    mutating func encode(_ value: Bool) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: String) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Double) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Float) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Int) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Int8) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Int16) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Int32) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: Int64) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: UInt) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        try self.container.encode(value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        try self.container.encode(value)
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        try value.encode(to: superEncoder())
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedEncodingContainer(_KeyedEncodingContainer(encoder: self.superEncoder() as! _NSONEncoder))
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        _UnkeyedEncodingContainer(encoder: self.superEncoder() as! _NSONEncoder)
    }
    
    mutating func superEncoder() -> Encoder {
        _NSONEncoder(encoder: container.superEncoder())
    }
}
