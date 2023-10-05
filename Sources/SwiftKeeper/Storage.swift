import Foundation
import SwiftUI

@propertyWrapper
public struct Storage<Value: Codable> {
    private let keeperManager: KeeperManager
    @State
    private var value: Value
    private let key: StorageKey

    public var wrappedValue: Value {
        get {
            value
        }
        nonmutating set {
            keeperManager.set(key: key, to: newValue)
            value = newValue
        }
    }
    
    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(_ storageType: StorageType, key: StorageKey, defaultValue: Value) {
        let keeperManager = storageType.manager()
        self.keeperManager = keeperManager
        self.key = key
        self._value = State(wrappedValue: keeperManager.get(key: key) ?? defaultValue)
    }
}

extension Storage: DynamicProperty { }

extension Storage {
    public init<T: Codable>(_ storageType: StorageType, key: StorageKey) where Value == Optional<T> {
        let keeperManager = storageType.manager()
        self.keeperManager = keeperManager
        self.key = key
        self._value = State(wrappedValue: keeperManager.get(key: key))
    }
    
    public init<T: Keepable>(_ storageType: StorageType) where Value == Optional<T> {
        let keeperManager = storageType.manager()
        self.keeperManager = keeperManager
        self.key = T.storageKey
        self._value = State(wrappedValue: keeperManager.get(key: key))
    }
}

extension Storage where Value: Keepable {
    public init(_ storageType: StorageType, defaultValue: Value) {
        let keeperManager = storageType.manager()
        self.keeperManager = keeperManager
        self.key = Value.storageKey
        self._value = State(wrappedValue: keeperManager.get(key: key) ?? defaultValue)
    }
    
}

extension Storage where Value: DefaultedKeepable {
    public init(_ storageType: StorageType) {
        let keeperManager = storageType.manager()
        self.keeperManager = keeperManager
        self.key = Value.storageKey
        self._value = State(wrappedValue: keeperManager.get(key: key) ?? Value.defaultStorageValue)
    }
    
}
