import Foundation

struct InMemoryKeeperManager: KeeperManager {
    let container = InMemoryStorageContainer.shared
    
    func get<Value: Codable>(key: StorageKey) -> Value? {
        guard let data = container.storage[key] else {
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
            container.storage[key] = data
        } catch {
            assertionFailure("Storage save failed. Encoding error: \(error.localizedDescription)")
        }
    }
}
