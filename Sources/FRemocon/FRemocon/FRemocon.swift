//
//  FRemocon.swift
//
//
//  Created by nakazawa fumito on 2021/03/27.
//
import FirebaseRemoteConfig

/// FRemocon is a wrapper class for RemoteConfig
@dynamicMemberLookup public final class FRemocon {
    public static let shared = FRemocon()

    let remoteConfig = RemoteConfig.remoteConfig()
    let configKeys = ConfigKeys()

    private init() {}
}

// MARK: RemoteConfig original method
extension FRemocon {

    public func fetch(completionHandler: ((RemoteConfigFetchStatus, Error?) -> Void)? = nil) {
        remoteConfig.fetch(completionHandler: completionHandler)
    }

    public func fetch(
        withExpirationDuration expirationDuration: TimeInterval,
        completionHandler: ((RemoteConfigFetchStatus, Error?) -> Void)? = nil
    ) {
        remoteConfig.fetch(
            withExpirationDuration: expirationDuration,
            completionHandler: completionHandler
        )

    }

    public func activate(completion: ((Bool, Error?) -> Void)? = nil) {
        remoteConfig.activate(completion: completion)
    }

    public func fetchAndActivate(completionHandler: ((RemoteConfigFetchAndActivateStatus, Error?) -> Void)? = nil) {
        remoteConfig.fetchAndActivate(completionHandler: completionHandler)
    }

    public func ensureInitialized(completionHandler: @escaping (Error?) -> Void) {
        remoteConfig.ensureInitialized(completionHandler: completionHandler)
    }

    public func allKeys(from source: RemoteConfigSource) -> [String] {
        return remoteConfig.allKeys(from: source)
    }

    public func keys(withPrefix prefix: String?) -> Set<String> {
        return remoteConfig.keys(withPrefix: prefix)
    }

    public func setDefaults(fromPlist fileName: String?) {
        remoteConfig.setDefaults(fromPlist: fileName)
    }

    public func configValue(forKey key: String?) -> RemoteConfigValue {
        return remoteConfig.configValue(forKey: key)
    }

    public func configValue(forKey key: String?, source: RemoteConfigSource) -> RemoteConfigValue {
        return remoteConfig.configValue(forKey: key, source: source)
    }
}

extension FRemocon {

    public func setDefaults<T: ConfigSerializable>(_ defaults: [KeyPath<ConfigKeys, ConfigKey<T>>: T]) where T.T == T {
        var defaults_: [String: NSObject] = [:]
        for (keyPath, value) in defaults {
            let key = configKeys[keyPath: keyPath]
            defaults_[key.key] = T.config.object(value: value)
        }
        remoteConfig.setDefaults(defaults_)
    }

    public func clearDefaults() {
        remoteConfig.setDefaults([:])
    }
}
