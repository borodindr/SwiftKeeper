import Foundation

protocol KeeperManager {
    func get<Value: Codable>(key: StorageKey) -> Value?
    func set<Value: Codable>(key: StorageKey, to newValue: Value?)
}

extension KeeperManager {
    func get<Value: Keepable>(_ type: Value.Type) -> Value? {
        get(key: type.storageKey)
    }
    
    func set<Value: Keepable>(_ type: Value.Type, to newValue: Value?) {
        set(key: type.storageKey, to: newValue)
    }
    
    func get<Value: Keepable>() -> Value? {
        get(Value.self)
    }
    
    func set<Value: Keepable>(_ newValue: Value?) {
        set(Value.self, to: newValue)
    }
    
    subscript<Value: Keepable>(_ key: Value.Type) -> Value? {
        get { self.get(key) }
        set { self.set(key, to: newValue) }
    }
}

extension KeeperManager {
    func get<Value: DefaultedKeepable>(_ type: Value.Type) -> Value {
        get(type) ?? .defaultStorageValue
    }
    
    func get<Value: DefaultedKeepable>() -> Value {
        get(Value.self)
    }
    
}
