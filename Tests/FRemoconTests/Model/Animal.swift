//
//  Animal.swift
//
//
//  Created by nakazawa fumito on 2021/03/28.
//

import Foundation

@testable import FRemocon

struct Animal: Codable, ConfigSerializable, Equatable {
    let id: Int
    let name: String
}
