protocol _Optional {
    var value: Self { get }
}

extension Optional: _Optional {
    
    var value: Self {
        switch self {
        case .none:
            return .none
        case .some(let wrapped):
            return .some(wrapped)
        }
    }
}
