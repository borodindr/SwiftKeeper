import Foundation
import SwiftUI

@propertyWrapper
public struct Storage<Value: Codable> {
    @ObservedObject
    private var keeperManager: KeeperManager<Value>
    private let defaultValue: Value

    public var wrappedValue: Value {
        get { keeperManager.value ?? defaultValue }
        nonmutating set {
            keeperManager.value = newValue
            keeperManager.set(newValue)
        }
    }
    
    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(_ storageType: StorageType, key: StorageKey, defaultValue: Value) {
        self.keeperManager = storageType.manager(key: key)
        self.defaultValue = defaultValue
    }
}

extension Storage: DynamicProperty { }

extension Storage {
    public init<T: Codable>(_ storageType: StorageType, key: StorageKey) where Value == Optional<T> {
        self.keeperManager = storageType.manager(key: key)
        self.defaultValue = nil
    }
    
    public init<T: Keepable>(_ storageType: StorageType) where Value == Optional<T> {
        self.keeperManager = storageType.manager(key: T.storageKey)
        self.defaultValue = nil
    }
}

extension Storage where Value: Keepable {
    public init(_ storageType: StorageType, defaultValue: Value) {
        self.keeperManager = storageType.manager(key: Value.storageKey)
        self.defaultValue = defaultValue
    }
}

extension Storage where Value: DefaultedKeepable {
    public init(_ storageType: StorageType) {
        self.keeperManager = storageType.manager(key: Value.storageKey)
        self.defaultValue = Value.defaultStorageValue
    }
}
