import Foundation

open class NSONDecoder: JSONDecoder {
    
    open override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        try super.decode(Wrapped<T>.self, from: data).value
    }
}

struct _NSONDecoder: Decoder {
    
    let decoder: Decoder
    
    var codingPath: [CodingKey] {
        decoder.codingPath
    }
    
    var userInfo: [CodingUserInfoKey : Any] {
        decoder.userInfo
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        try KeyedDecodingContainer(_KeyedDecodingContainer(decoder: self))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        try _UnkeyedDecodingContainer(decoder: self)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        try _SingleValueDecodingContainer(decoder: self)
    }
}
