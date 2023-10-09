import Foundation

public enum StorageType {
    case inMemory
    case userDefaults(UserDefaultsType)
    
    public static var userDefaults: Self {
        .userDefaults(.standard)
    }
    
    func manager<Value: Codable>(key: StorageKey) -> KeeperManager<Value> {
        switch self {
        case .inMemory:
            return InMemoryKeeperManager(key: key)
        case .userDefaults(let userDefaultsType):
            return UserDefaultsKeeperManager(key: key, userDefaultsType: userDefaultsType)
        }
    }
}

public extension StorageType {
    enum UserDefaultsType {
        case standard
        case appGroup(String)
    }
}
