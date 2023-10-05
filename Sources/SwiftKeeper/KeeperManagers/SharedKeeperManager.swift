import Foundation

struct SharedKeeperManager: UserDefaultsKeeperManager {
    let userDefaults: UserDefaults = {
        let name = SwiftKeeperConfiguration.appGroupIdentifier
        guard !name.isEmpty else {
            fatalError("App Group identifier was not set. Please set the identifier in 'SwiftKeeperConfiguration.appGroupIdentifier'.")
        }
        guard let userDefaults = UserDefaults(suiteName: name) else {
            fatalError("Failed to create UserDefaults for App Group '\(name)'")
        }
        return userDefaults
    }()
}
