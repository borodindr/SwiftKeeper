import Foundation

public enum StorageType {
    case inMemory
    case persistent
    case shared
    
    func manager<Value: Codable>(key: StorageKey) -> KeeperManager<Value> {
        switch self {
        case .inMemory:
            return InMemoryKeeperManager(key: key)
        case .persistent:
            return PersistentKeeperManager(key: key)
        case .shared:
            return SharedKeeperManager(key: key)
        }
    }
}
