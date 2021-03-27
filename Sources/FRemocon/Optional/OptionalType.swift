//
//  OptionalType.swift
//
//
//  Created by nakazawa fumito on 2021/03/28.
//

import Foundation

public protocol OptionalType {
    associatedtype Wrapped
    var wrapped: Wrapped? { get }
    static var empty: Self { get }
}

extension Optional: OptionalType {
    public var wrapped: Wrapped? { self }
    public static var empty: Self { nil }
}
