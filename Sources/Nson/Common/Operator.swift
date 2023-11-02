
infix operator <-

public func <- (lhs: String, rhs: String) -> ([String], String) {
    ([rhs], lhs)
}

public func <- (lhs: String, rhs: [String]) -> ([String], String) {
    (rhs, lhs)
}
