import Foundation

class InMemoryStorageContainer {
    static let shared = InMemoryStorageContainer()
    var storage: [StorageKey: Data] = [:]
    
    private init() { }
}
