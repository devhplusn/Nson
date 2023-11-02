import Foundation

struct _SingleValueEncodingContainer: SingleValueEncodingContainer {
    
    private let encoder: _NSONEncoder
    private var container: SingleValueEncodingContainer
    
    init(encoder: _NSONEncoder) {
        self.encoder = encoder
        self.container = encoder.encoder.singleValueContainer()
    }
    
    var codingPath: [CodingKey] {
        self.encoder.codingPath
    }
    
    mutating func encodeNil() throws {
        try container.encodeNil()
    }
    
    mutating func encode(_ value: Bool) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: String) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Double) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Float) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int8) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int16) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int32) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: Int64) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        try container.encode(value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        try container.encode(value)
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        try value.encode(to: self.encoder)
    }
}

