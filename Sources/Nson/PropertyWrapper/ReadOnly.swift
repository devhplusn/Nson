
@propertyWrapper
public struct ReadOnly<Value> {
    
    private var value: Value
    
    public var wrappedValue: Value {
        get { value }
    }
    
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}

extension ReadOnly: Decodable where Value: Decodable {
    
    public init(from decoder: Decoder) throws {
        self.value = try Value(from: decoder)
    }
}

extension ReadOnly: Encodable where Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try self.value.encode(to: encoder)
    }
}
