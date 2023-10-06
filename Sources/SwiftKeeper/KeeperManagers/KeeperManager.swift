import Foundation

class KeeperManager<Value: Codable>: ObservableObject {
    @Published
    var value: Value?
    let key: StorageKey
    
    init(key: StorageKey) {
        self.key = key
        value = get()
        subscribeOnChanges { [weak self] in
            guard let self else { return }
            self.value = self.get()
        }
    }
    
    func fetch() -> Data? {
        fatalError("Method 'fetch()' was not implemented.")
    }
    
    func save(_ newValue: Data?) {
        fatalError("Method 'save(_:)' was not implemented.")
    }
    
    func publishChanges() {
        fatalError("Method 'publishChanges()' was not implemented.")
    }
    
    func subscribeOnChanges(changesHandler: @escaping () -> Void) {
        fatalError("Method 'subscribeOnChanges()' was not implemented.")
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
            publishChanges()
        } catch {
            assertionFailure("Storage save failed. Encoding error: \(error.localizedDescription)")
        }
    }
}
