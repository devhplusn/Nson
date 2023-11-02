public protocol CodeTransformable: DecodeTransformable, EncodeTransformable where DecodeType == EncodeType, Value == Value { }
