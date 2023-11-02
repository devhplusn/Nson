
public protocol NSON { }

extension NSON {
    public typealias Key<Value> = KeyValue<Self, Value>
}
