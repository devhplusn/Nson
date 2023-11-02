import Foundation

open class NSONEncoder: JSONEncoder {
    open override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        try super.encode(Wrapped(value))
    }
}

struct _NSONEncoder: Encoder {
    
    let encoder: Encoder
    
    var codingPath: [CodingKey] {
        encoder.codingPath
    }
    
    var userInfo: [CodingUserInfoKey : Any] {
        encoder.userInfo
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        KeyedEncodingContainer(_KeyedEncodingContainer<Key>(encoder: self))
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        _UnkeyedEncodingContainer(encoder: self)
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        _SingleValueEncodingContainer(encoder: self)
    }
}
