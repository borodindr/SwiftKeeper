import Foundation

final class UserDefaultsProvider {
    private static var cachedUserDefaults: [String: UserDefaults] = [:]
    
    static func getUserDefaults(type userDefaultsType: StorageType.UserDefaultsType) -> UserDefaults {
        switch userDefaultsType {
        case .standard:
            return .standard
        case .appGroup(let appGroup):
            if let cached = cachedUserDefaults[appGroup] {
                return cached
            }
            guard let userDefaults = UserDefaults(suiteName: appGroup) else {
                fatalError("Failed to create UserDefaults for App Group '\(appGroup)'")
            }
            cachedUserDefaults[appGroup] = userDefaults
            return userDefaults
        }
    }
}
