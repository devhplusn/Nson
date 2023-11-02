import Foundation

extension KeyPath {
    
    var propertyName: String {
        String(describing: self).split(separator: ".").last?.string ?? ""
    }
}

extension Substring {
    
    var string: String {
        String(self)
    }
}
