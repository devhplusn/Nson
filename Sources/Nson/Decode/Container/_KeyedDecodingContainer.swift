import Foundation

struct _KeyedDecodingContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
    
    private let decoder: _NSONDecoder
    private let container: KeyedDecodingContainer<Key>
    private let containerNCodingKey: KeyedDecodingContainer<NCodingKey>
    
    init(decoder: _NSONDecoder) throws {
        self.decoder = decoder
        self.container = try decoder.decoder.container(keyedBy: Key.self)
        self.containerNCodingKey = try decoder.decoder.container(keyedBy: NCodingKey.self)
    }
    
    var codingPath: [CodingKey] {
        self.decoder.codingPath
    }
    
    var allKeys: [Key] {
        self.container.allKeys
    }
    
    func contains(_ key: Key) -> Bool {
        self.container.contains(key)
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        try self.container.decodeNil(forKey: key)
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try self.container.decode(type, forKey: key)
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        switch type {
        case let typeIdentifiar as TypeIdentifiable.Type:
            return try self.decodeValue(typeIdentifiar, forKey: key)
        case is FlatDecodeValue.Type:
            return try T(from: self.decoder)
        default:
            return try T(from: superDecoder(forKey: key))
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        try KeyedDecodingContainer(_KeyedDecodingContainer<NestedKey>(decoder: self.superDecoder(forKey: key) as! _NSONDecoder))
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        try _UnkeyedDecodingContainer(decoder: self.superDecoder(forKey: key) as! _NSONDecoder)
    }
    
    func superDecoder() throws -> Decoder {
        try _NSONDecoder(decoder: self.container.superDecoder())
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        try _NSONDecoder(decoder: self.container.superDecoder(forKey: key))
    }
}

extension _KeyedDecodingContainer {
    
    private func decodeValue<T: Decodable>(_ type: TypeIdentifiable.Type, forKey key: Key) throws -> T {
        guard let box = BoxContainer.box(identifier: type.identifier, key: key) else {
            throw self.keyNotFound(forKey: key)
        }
        return try T(from: self.decoder(box: box))
    }
    
    private func decoder(box: Box) throws -> Decoder {
        let container = try box.path.reduce(containerNCodingKey) {
            try $0.nestedContainer(keyedBy: NCodingKey.self, forKey: $1)
        }
        
        return try _NSONDecoder(decoder: container.superDecoder(forKey: box.key))
    }
    
    private func keyNotFound(forKey key: Key) -> DecodingError {
        let description = """
        No value associated with key \(key) ("\(key.stringValue)").
        """
        return DecodingError.keyNotFound(key, DecodingError.Context(codingPath: codingPath, debugDescription: description))
    }
}
