//
//  ConfigKey.swift
//
//
//  Created by nakazawa fumito on 2021/03/27.
//

import Foundation

public struct ConfigKey<Value: ConfigSerializable> {
    public let key: String
    public let defaultValue: Value.T?

    public init(key: String, defaultValue: Value.T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

extension ConfigKey where Value: OptionalType, Value.Wrapped: ConfigSerializable {
    public init(key: String) {
        self.key = key
        defaultValue = nil
    }
}
