import Combine
import Foundation

final class InMemoryKeeperManager<Value: Codable>: KeeperManager<Value> {
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
