import Foundation

public protocol Keepable: Codable {
    static var storageKey: StorageKey { get }
}

public extension Keepable {
    static var storageKey: StorageKey {
        StorageKey(String(describing: Self.self))
    }
}
