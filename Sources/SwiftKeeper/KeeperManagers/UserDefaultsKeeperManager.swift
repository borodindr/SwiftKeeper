import Foundation

protocol UserDefaultsKeeperManager: KeeperManager {
    var userDefaults: UserDefaults { get }
}

extension UserDefaultsKeeperManager {
    func get<Value: Codable>(key: StorageKey) -> Value? {
        guard let data = userDefaults.data(forKey: key.keyValue) else {
            return nil
        }
        do {
            let value = try JSONDecoder().decode(Value.self, from: data)
            return value
        } catch {
            assertionFailure("Storage load failed. Decoding error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func set<Value: Codable>(key: StorageKey, to newValue: Value?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key.keyValue)
        } catch {
            assertionFailure("Storage save failed. Encoding error: \(error.localizedDescription)")
        }
    }
}
