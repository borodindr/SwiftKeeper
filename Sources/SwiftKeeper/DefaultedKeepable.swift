import Foundation

public protocol DefaultedKeepable: Keepable {
    static var defaultStorageValue: Self { get }
}
