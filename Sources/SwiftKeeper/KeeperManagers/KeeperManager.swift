import Foundation

class KeeperManager<Value: Codable>: ObservableObject {
    @Published
    var value: Value? {
        didSet {
            set(value)
        }
    }
    let key: StorageKey
    
    init(key: StorageKey) {
        self.key = key
        value = get()
    }
    
    func fetch() -> Data? {
        fatalError("Method 'fetch()' was not implemented.")
    }
    func save(_ newValue: Data?) {
        fatalError("Method 'save(_:)' was not implemented.")
    }
}

class CacheContainer {
    var cache: [StorageKey: Data?] = [:]
}

extension KeeperManager {
    func get() -> Value? {
        let data = fetch()
        guard let data else { return nil }
        do {
            let value = try JSONDecoder().decode(Value.self, from: data)
            return value
        } catch {
            assertionFailure("Storage load failed. Decoding error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func set(_ newValue: Value?) {
        do {
            var data: Data? = nil
            if let newValue {
                data = try JSONEncoder().encode(newValue)
            }
            save(data)
        } catch {
            assertionFailure("Storage save failed. Encoding error: \(error.localizedDescription)")
        }
    }
}
