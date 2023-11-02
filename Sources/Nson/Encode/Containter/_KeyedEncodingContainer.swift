import Foundation

struct _KeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    
    private let encoder: _NSONEncoder
    
    private var container: KeyedEncodingContainer<Key>
    private var containerNCodingKey: KeyedEncodingContainer<NCodingKey>
    
    init(encoder: _NSONEncoder) {
        self.encoder = encoder
        self.container = encoder.encoder.container(keyedBy: Key.self)
        self.containerNCodingKey = encoder.encoder.container(keyedBy: NCodingKey.self)
    }
    
    var codingPath: [CodingKey] {
        self.encoder.codingPath
    }
    
    mutating func encodeNil(forKey key: Key) throws {
        try self.container.encodeNil(forKey: key)
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        try self.container.encode(value, forKey: key)
    }
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        switch value {
        case let typeIdentifiar as TypeIdentifiable:
            try self.encode(value, typeIdentifiar: typeIdentifiar, forKey: key)
        case is FlatEncodeValue:
            var container = self.encoder.singleValueContainer()
            try container.encode(value)
        default:
            try self.container.encode(value, forKey: key)
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedEncodingContainer(_KeyedEncodingContainer<NestedKey>(encoder: self.superEncoder(forKey: key) as! _NSONEncoder))
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        _UnkeyedEncodingContainer(encoder: self.superEncoder(forKey: key) as! _NSONEncoder)
    }
    
    mutating func superEncoder() -> Encoder {
        _NSONEncoder(encoder: self.container.superEncoder())
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        _NSONEncoder(encoder: self.container.superEncoder(forKey: key))
    }
}

extension _KeyedEncodingContainer {
    
    private mutating func encode<T: Encodable>(_ value: T, typeIdentifiar: TypeIdentifiable, forKey key: Key) throws {
        guard let box = BoxContainer.box(identifier: typeIdentifiar.identifier, key: key) else {
            throw self.invalidValue(value, forKey: key)
        }
        try value.encode(to: self.encoder(box: box))
    }
    
    private func encoder(box: Box) throws -> Encoder {
        var container = box.path.reduce(into: containerNCodingKey) {
            $0 = $0.nestedContainer(keyedBy: NCodingKey.self, forKey: $1)
        }
        return _NSONEncoder(encoder: container.superEncoder(forKey: box.key))
    }
    
    private func invalidValue(_ value: Any, forKey key: Key) -> EncodingError {
        let description = """
        No key value associated with value \(value) ("\(key.stringValue)").
        """
        return EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath, debugDescription: description))
    }
}

