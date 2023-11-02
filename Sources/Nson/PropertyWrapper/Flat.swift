import Foundation

@propertyWrapper
public struct Flat<Value> {
    
    private var value: Value?
    public var wrappedValue: Value {
        get {
            guard let _optional = value as? _Optional, let _value = _optional.value as? Value else {
                fatalError("@\(Self.self) has not been set. For non-optional value types, you must set the value before calling it.")
            }
            return _value
        } set {
            value = newValue
        }
    }
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Flat: FlatDecodeValue where Self: Decodable { }

extension Flat: FlatEncodeValue where Self: Encodable { }

extension Flat: Decodable where Value: Decodable {
    
    public init(from decoder: Decoder) throws {
        self.value = try decoder.singleValueContainer().decode(Value.self)
    }
}

extension Flat: Encodable where Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}

protocol FlatDecodeValue: Decodable { }

protocol FlatEncodeValue: Encodable { }
