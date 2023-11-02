import Foundation

struct Box {
    
    let key: NCodingKey
    
    let path: [NCodingKey]
    
    init(key: String, path: [String]) {
        self.key = NCodingKey(key)
        self.path = path.compactMap { NCodingKey($0) }
    }
}

final class BoxContainer {
    
    let lock = NSLock()
    
    static let shared = BoxContainer()
    
    private init() { }
    
    var containers: [ObjectIdentifier: [String: Box]] = [:]
    
    static func regist(identifier: ObjectIdentifier, propertyName: String, key: String, path: [String]) {
        
        shared.lock.lock(); defer { shared.lock.unlock() }
        
        guard shared.containers[identifier]?[propertyName] == nil else {
            return
        }
        
        shared.containers[identifier] = shared.containers[identifier] ?? [:]
        shared.containers[identifier]![propertyName] = Box(key: key, path: path)
    }
    
    static func box(identifier: ObjectIdentifier, key: CodingKey) -> Box? {
        
        shared.lock.lock(); defer { shared.lock.unlock() }
        
        return shared.containers[identifier]?[key.stringValue]
    }
}
