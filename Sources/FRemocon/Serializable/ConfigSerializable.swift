//
//  ConfigSerializable.swift
//
//
//  Created by nakazawa fumito on 2021/03/27.
//

import Foundation

public protocol ConfigSerializable {
    typealias T = Bridge.T

    associatedtype Bridge: ConfigBridge
    associatedtype ArrayBridge: ConfigBridge

    static var config: Bridge { get }
    static var configArray: ArrayBridge { get }
}

extension ConfigSerializable where T: ConfigSerializable { public static var configArray: ConfigArrayBridge<[T]> { .init() } }

extension String: ConfigSerializable { public static var config: ConfigStringBridge { .init() } }

extension Int: ConfigSerializable { public static var config: ConfigIntBridge { .init() } }

extension Double: ConfigSerializable { public static var config: ConfigDoubleBridge { .init() } }

extension Float: ConfigSerializable { public static var config: ConfigFloatBridge { .init() } }

extension Data: ConfigSerializable { public static var config: ConfigDataBridge { .init() } }

extension Bool: ConfigSerializable { public static var config: ConfigBoolBridge { .init() } }

extension Optional: ConfigSerializable where Wrapped: ConfigSerializable {
    public static var config: ConfigOptionalBridge<Wrapped.Bridge> { .init(bridge: Wrapped.config) }
    public static var configArray: ConfigOptionalBridge<Wrapped.ArrayBridge> { .init(bridge: Wrapped.configArray) }
}

extension Array: ConfigSerializable where Element: ConfigSerializable {
    public static var config: Element.ArrayBridge { Element.configArray }
    public static var configArray: Element.ArrayBridge { fatalError("Multidimensional arrays are not supported yet") }
}

extension ConfigSerializable where Self: Codable {
    public static var config: ConfigCodableBridge<Self> { .init() }
    public static var configArray: ConfigCodableBridge<[Self]> { .init() }
}

extension ConfigSerializable where Self: RawRepresentable {
    public static var config: ConfigRawRepresentableBridge<Self> { .init() }
    public static var configArray: ConfigArrayRawRepresentableBridge<[Self]> { .init() }
}
