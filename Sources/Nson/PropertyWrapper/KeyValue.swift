@propertyWrapper
public struct KeyValue<Root, Value> {
    
    typealias Box = (propertyName: String, key: String, path: [String])
    
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
    
    @available(*, unavailable)
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    public init(wrappedValue: Value, _ closure: @autoclosure () -> ([String], String)) {
        self.value = wrappedValue
        Self.regist(closure())
    }
    
    public init(wrappedValue: Value, to keyPath: KeyPath<Root, Value>, _ keys: String...) {
        self.value = wrappedValue
        Self.regist((keys, keyPath.propertyName))
    }
    
    public init(_ closure: @autoclosure () -> ([String], String)) {
        Self.regist(closure())
    }
        
    public init(to keyPath: KeyPath<Root, Value>, _ keys: String...) {
        Self.regist((keys, keyPath.propertyName))
    }
    
    private static func regist(_ value: (path: [String], identifier: String)) {
        var result = value
        guard let key = result.path.popLast() else {
            fatalError("@\(Self.self) must be created by setting one or more keys.")
        }
        
        let box = Box(propertyName: value.1, key: key, path: result.0)
        BoxContainer.regist(identifier: identifier, propertyName: box.propertyName, key: box.key, path: box.path)
    }
}

extension KeyValue: Decodable where Root: Decodable, Value: Decodable {
    
    public init(from decoder: Decoder) throws {
        self.value = try decoder.singleValueContainer().decode(Value.self)
    }
}

extension KeyValue: Encodable where Root: Encodable, Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}

extension KeyValue: TypeIdentifiable {
    
    var identifier: ObjectIdentifier { ObjectIdentifier(Root.self) }
    
    static var identifier: ObjectIdentifier { ObjectIdentifier(Root.self) }
}
