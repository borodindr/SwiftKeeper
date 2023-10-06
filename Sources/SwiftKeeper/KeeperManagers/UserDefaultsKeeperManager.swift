import Foundation

class UserDefaultsKeeperManager<Value: Codable>: KeeperManager<Value> {
    let userDefaults: UserDefaults
    
    init(key: StorageKey, userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        super.init(key: key)
    }
    
    override func fetch() -> Data? {
        userDefaults.data(forKey: key.keyValue)
    }
    
    override func save(_ newValue: Data?) {
        userDefaults.set(newValue, forKey: key.keyValue)
    }
}
