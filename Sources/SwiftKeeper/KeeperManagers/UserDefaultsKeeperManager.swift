import Foundation
import Combine

class UserDefaultsKeeperManager<Value: Codable>: KeeperManager<Value> {
    let userDefaults: UserDefaults
    private var changesSubscription: AnyCancellable?
    
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
    
    override func publishChanges() {
        // UserDefaults will publish changes by itself.
    }
    
    override func subscribeOnChanges(changesHandler: @escaping () -> Void) {
        changesSubscription = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
            .dropFirst()
            .print()
            .sink { [weak self] notification in
                guard
                    let userDefaults = notification.object as? UserDefaults,
                    userDefaults === self?.userDefaults
                else {
                    return
                }
                changesHandler()
            }
    }
}
