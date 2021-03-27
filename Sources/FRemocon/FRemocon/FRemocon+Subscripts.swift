//
//  FRemocon+Subscripts.swift
//
//
//  Created by nakazawa fumito on 2021/03/27.
//
import FirebaseRemoteConfig
import Foundation

// MARK: Get value type-safely
extension FRemocon {
    public subscript<T: ConfigSerializable>(dynamicMember keyPath: KeyPath<ConfigKeys, ConfigKey<T>>) -> T.T where T.T == T {
        let key = configKeys[keyPath: keyPath]
        if let value = T.config.get(key: key.key, remoteConfig: remoteConfig) {
            return value
        } else if let defaultValue = key.defaultValue {
            return defaultValue
        } else {
            fatalError("should not reach here")
        }
    }

    public subscript<T: ConfigSerializable>(dynamicMember keyPath: KeyPath<ConfigKeys, ConfigKey<T>>) -> T.T where T: OptionalType, T.T == T {
        let key = configKeys[keyPath: keyPath]
        if let value = T.config.get(key: key.key, remoteConfig: remoteConfig),
            let value_ = value as? T.Wrapped
        {
            return value_ as! T
        } else if let defaultValue = key.defaultValue {
            return defaultValue
        } else {
            return T.empty
        }
    }
}

// MARK: Get / Set to remoteConfig value
extension FRemocon {
    public subscript<Value>(dynamicMember keyPath: KeyPath<RemoteConfig, Value>) -> Value {
        return remoteConfig[keyPath: keyPath]
    }

    public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<RemoteConfig, Value>) -> (Value) -> Void {
        return { [remoteConfig] value in
            remoteConfig[keyPath: keyPath] = value
        }
    }
}
