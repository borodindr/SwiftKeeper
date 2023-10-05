import Foundation

public struct StorageKey {
    var keyValue: String
    
    public init(_ keyValue: String) {
        self.keyValue = keyValue
    }
}

extension StorageKey: Hashable { }

extension StorageKey: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
