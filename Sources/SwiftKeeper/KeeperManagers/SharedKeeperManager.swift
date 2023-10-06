import Foundation

class SharedKeeperManager<Value: Codable>: UserDefaultsKeeperManager<Value> {
    init(key: StorageKey) {
        let name = SwiftKeeperConfiguration.appGroupIdentifier
        guard !name.isEmpty else {
            fatalError("App Group identifier was not set. Please set the identifier in 'SwiftKeeperConfiguration.appGroupIdentifier'.")
        }
        guard let userDefaults = UserDefaults(suiteName: name) else {
            fatalError("Failed to create UserDefaults for App Group '\(name)'")
        }
        super.init(key: key, userDefaults: userDefaults)
    }
}
