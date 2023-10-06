import Foundation

class InMemoryKeeperManager<Value: Codable>: KeeperManager<Value> {
    let container = InMemoryStorageContainer.shared
    
    override func fetch() -> Data? {
        container.storage[key]
    }
    
    override func save(_ newValue: Data?) {
        container.storage[key] = newValue
    }
}
