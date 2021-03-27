//
//  ConfigKeys.swift
//
//
//  Created by nakazawa fumito on 2021/03/28.
//

import Foundation

@testable import FRemocon

extension ConfigKeys {
    // string
    var text: ConfigKey<String> { .init(key: "text", defaultValue: "defaultValue") }
    var optionalText: ConfigKey<String?> { .init(key: "optionalText") }

    // bool
    var flag: ConfigKey<Bool> { .init(key: "flag", defaultValue: false) }
    var optionalFlag: ConfigKey<Bool?> { .init(key: "optionalFlag") }

    // int
    var intNumber: ConfigKey<Int> { .init(key: "intNumber", defaultValue: 1) }
    var optionalIntNumber: ConfigKey<Int?> { .init(key: "optionalIntNumber") }

    // double
    var doubleNumber: ConfigKey<Double> { .init(key: "doubleNumber", defaultValue: 1) }
    var optionalDoubleNumber: ConfigKey<Double?> { .init(key: "optionalDoubleNumber") }

    // float
    var floatNumber: ConfigKey<Float> { .init(key: "floatNumber", defaultValue: 1) }
    var optionalFloatNumber: ConfigKey<Float?> { .init(key: "optionalFloatNumber") }

    // data
    var data: ConfigKey<Data> { .init(key: "data", defaultValue: "hoge".data(using: .utf8)!) }
    var optionalData: ConfigKey<Data?> { .init(key: "optionalData") }

    // enum_string
    var fruit: ConfigKey<Fruit> { .init(key: "fruit", defaultValue: .apple) }
    var optionalFruit: ConfigKey<Fruit?> { .init(key: "optionalFruit") }

    // enum_int
    var number: ConfigKey<Number> { .init(key: "number", defaultValue: .one) }
    var optionalNumber: ConfigKey<Number?> { .init(key: "optionalNumber") }

    // codable
    var animal: ConfigKey<Animal> { .init(key: "animal", defaultValue: .init(id: 0, name: "cat")) }
    var optionalAnimal: ConfigKey<Animal?> { .init(key: "optionalAnimal") }

    // int_array
    var intArray: ConfigKey<[Int]> { .init(key: "intArray", defaultValue: []) }

    // string_array
    var stringArray: ConfigKey<[String]> { .init(key: "stringArray", defaultValue: []) }

    // animal_array
    var animalArray: ConfigKey<[Animal]> { .init(key: "animalArray", defaultValue: []) }

    // enum_array_int
    var numberArray: ConfigKey<[Number]> { .init(key: "numberArray", defaultValue: []) }

    // enum_array_string
    var fruitArray: ConfigKey<[Fruit]> { .init(key: "fruitArray", defaultValue: []) }
}
