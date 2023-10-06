import Combine
import Foundation

class InMemoryKeeperManager<Value: Codable>: KeeperManager<Value> {
    let container = InMemoryStorageContainer.shared
    private var changesSubscription: AnyCancellable?
    
    override func fetch() -> Data? {
        container.storage[key]
    }
    
    override func save(_ newValue: Data?) {
        container.storage[key] = newValue
    }
    
    override func publishChanges() {
        NotificationCenter.default.post(
            name: .inMemoryStorageDidChange,
            object: nil,
            userInfo: [
                NotificationKey.inMemoryStorageKeyNotificationKey: key
            ]
        )
    }
    
    override func subscribeOnChanges(changesHandler: @escaping () -> Void) {
        changesSubscription = NotificationCenter.default.publisher(for: .inMemoryStorageDidChange)
            .print()
            .sink { [weak self] notification in
                let notificationKey = NotificationKey.inMemoryStorageKeyNotificationKey
                guard
                    let self,
                    let userInfo = notification.userInfo,
                    let storageKey = userInfo[notificationKey] as? StorageKey,
                    storageKey == self.key
                else {
                    return
                }
                changesHandler()
            }
    }
}

enum NotificationKey {
    static let inMemoryStorageKeyNotificationKey = "swift-keeper.in-memory-keeper-manager.storage-key"
}

extension Notification.Name {
    static let inMemoryStorageDidChange = Notification.Name("swift-keeper.in-memory-keeper-manager.storage-did-change")
}
