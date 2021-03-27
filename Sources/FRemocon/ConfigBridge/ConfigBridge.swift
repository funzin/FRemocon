//
//  ConfigBridge.swift
//
//
//  Created by nakazawa fumito on 2021/03/27.
//

import FirebaseRemoteConfig

public protocol ConfigBridge {
    associatedtype T

    func object(value: T?) -> NSObject?
    func get(key: String, remoteConfig: RemoteConfig) -> T?
    func deserialize(_ object: Any) -> T?
}

public struct ConfigBoolBridge: ConfigBridge {
    public init() {}

    public func object(value: Bool?) -> NSObject? { return value as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> Bool? { return remoteConfig[key].boolValue }

    public func deserialize(_: Any) -> Bool? { return nil }
}

public struct ConfigStringBridge: ConfigBridge {
    public init() {}

    public func object(value: String?) -> NSObject? { return value as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> String? { return remoteConfig[key].stringValue }

    public func deserialize(_: Any) -> String? { return nil }
}

public struct ConfigIntBridge: ConfigBridge {
    public init() {}

    public func object(value: Int?) -> NSObject? { return value as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> Int? { return remoteConfig[key].numberValue.intValue }

    public func deserialize(_: Any) -> Int? { return nil }
}

public struct ConfigDoubleBridge: ConfigBridge {
    public init() {}

    public func object(value: Double?) -> NSObject? { return value as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> Double? { return remoteConfig[key].numberValue.doubleValue }

    public func deserialize(_: Any) -> Double? { return nil }
}

public struct ConfigFloatBridge: ConfigBridge {
    public init() {}

    public func object(value: Float?) -> NSObject? { return value as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> Float? { return remoteConfig[key].numberValue.floatValue }

    public func deserialize(_: Any) -> Float? { return nil }
}

public struct ConfigDataBridge: ConfigBridge {
    public init() {}

    public func object(value: Data?) -> NSObject? { return value as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> Data? { return remoteConfig[key].dataValue }

    public func deserialize(_: Any) -> Data? { return nil }
}

public struct ConfigArrayBridge<T: Collection>: ConfigBridge where T.Element: ConfigSerializable {
    public init() {}

    public func object(value: T?) -> NSObject? { return value.flatMap { try? JSONSerialization.data(withJSONObject: $0, options: []) } as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> T? { return deserialize(remoteConfig[key].dataValue) }

    public func deserialize(_ object: Any) -> T? {
        guard let data = object as? Data else { return nil }
        let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? T
        return jsonObject
    }
}

public struct ConfigOptionalBridge<Bridge: ConfigBridge>: ConfigBridge {
    public typealias T = Bridge.T?

    private let bridge: Bridge

    init(bridge: Bridge) { self.bridge = bridge }

    public func object(value: T?) -> NSObject? { return bridge.object(value: value as? Bridge.T) }

    public func get(key: String, remoteConfig: RemoteConfig) -> T? { return bridge.get(key: key, remoteConfig: remoteConfig) }

    public func deserialize(_: Any) -> T? { return nil }
}

public struct ConfigCodableBridge<T: Codable>: ConfigBridge {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.encoder = encoder
        self.decoder = decoder
    }

    public func object(value: T?) -> NSObject? { return try? encoder.encode(value) as NSObject? }

    public func get(key: String, remoteConfig: RemoteConfig) -> T? { return try? decoder.decode(T.self, from: remoteConfig[key].dataValue) }

    public func deserialize(_: Any) -> T? { return nil }
}

public struct ConfigRawRepresentableBridge<T: RawRepresentable>: ConfigBridge {
    public func object(value: T?) -> NSObject? { return value?.rawValue as? NSObject }

    public func get(key: String, remoteConfig: RemoteConfig) -> T? {
        return remoteConfig[key].stringValue.flatMap(deserialize) ?? deserialize(remoteConfig[key].numberValue)
    }

    public func deserialize(_ object: Any) -> T? { return (object as? T.RawValue).flatMap(T.init(rawValue:)) }
}

public struct ConfigArrayRawRepresentableBridge<T: Collection>: ConfigBridge where T.Element: RawRepresentable {
    public init() {}

    public func object(value: T?) -> NSObject? {
        return value.flatMap { try? JSONSerialization.data(withJSONObject: $0.compactMap { $0.rawValue }, options: []) } as NSObject?
    }

    public func get(key: String, remoteConfig: RemoteConfig) -> T? {
        let deserialized =
            deserialize(remoteConfig[key].dataValue)
            ?? remoteConfig[key].stringValue.flatMap(deserialize)
            ?? deserialize(remoteConfig[key].numberValue)
        return deserialized
    }

    public func deserialize(_ object: Any) -> T? {
        guard let data = object as? Data else { return nil }
        let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])).flatMap { $0 as? [T.Element.RawValue] }
        return jsonObject?.compactMap(T.Element.init(rawValue:)) as? T
    }
}
