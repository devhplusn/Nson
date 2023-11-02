import Foundation

public protocol DecodeTransformable: ValueType {
    associatedtype DecodeType: Decodable
    static func transform(decoded: DecodeType) throws -> Value
}

