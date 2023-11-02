import Foundation

public protocol EncodeTransformable: ValueType {
    associatedtype EncodeType: Encodable
    static func transform(value: Value) throws -> EncodeType
}
