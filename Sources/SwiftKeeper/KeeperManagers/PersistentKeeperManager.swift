import Foundation

class PersistentKeeperManager<Value: Codable>: UserDefaultsKeeperManager<Value> {
    init(key: StorageKey) {
        super.init(key: key, userDefaults: .standard)
    }
}
