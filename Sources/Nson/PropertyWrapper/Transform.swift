
@propertyWrapper
public struct Transform<T: ValueType> {
    
    public typealias Value = T.Value
    
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

extension Transform: Decodable where T: DecodeTransformable {
    
    public init(from decoder: Decoder) throws {
        self.value = try T.transform(decoded: decoder.singleValueContainer().decode(T.DecodeType.self))
    }
}

extension Transform: Encodable where T: EncodeTransformable {
    
    public func encode(to encoder: Encoder) throws {
        try T.transform(value: self.wrappedValue).encode(to: encoder)
    }
}
