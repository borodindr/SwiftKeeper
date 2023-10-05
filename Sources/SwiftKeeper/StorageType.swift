import Foundation

public enum StorageType {
    case inMemory, persistent, shared
    
    func manager() -> KeeperManager {
        switch self {
        case .inMemory:
            return InMemoryKeeperManager()
        case .persistent:
            return PersistentKeeperManager()
        case .shared:
            return SharedKeeperManager()
        }
    }
}
