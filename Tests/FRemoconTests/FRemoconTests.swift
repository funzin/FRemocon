//
//  FRemoconTests.swift
//
//
//  Created by nakazawa fumito on 2021/03/28.
//

import Firebase
import XCTest

@testable import FRemocon

final class FRemoconTests: XCTestCase {
    var remoteConfig: FRemocon!

    override func setUpWithError() throws {
        _ = FirebaseSetUp.shared
        remoteConfig = FRemocon.shared
        remoteConfig.clearDefaults()
    }

    func test_setDefaults_plist() {
        XCTAssertEqual(remoteConfig.text, "")
        remoteConfig.setDefaults(fromPlist: "dummyInfo")
        XCTAssertEqual(remoteConfig.text, "dummyText")
    }

    func test_clearDefaults() {
        XCTAssertEqual(remoteConfig.text, "")
        XCTAssertEqual(remoteConfig.optionalText, "")

        remoteConfig.setDefaults([\.text: "text"])
        XCTAssertEqual(remoteConfig.text, "text")
        XCTAssertEqual(remoteConfig.optionalText, "")

        remoteConfig.setDefaults([\.optionalText: "optionalText"])
        XCTAssertEqual(remoteConfig.text, "")
        XCTAssertEqual(remoteConfig.optionalText, "optionalText")

        remoteConfig.clearDefaults()
        XCTAssertEqual(remoteConfig.text, "")
        XCTAssertEqual(remoteConfig.optionalText, "")
    }

    func test_string() {
        XCTAssertEqual(remoteConfig.text, "")
        remoteConfig.setDefaults([\.text: "text"])
        XCTAssertEqual(remoteConfig.text, "text")
    }

    func test_optional_string() {
        XCTAssertEqual(remoteConfig.optionalText, "")
        remoteConfig.setDefaults([\.optionalText: "optionalText"])
        XCTAssertEqual(remoteConfig.optionalText, "optionalText")
    }

    func test_bool() {
        XCTAssertEqual(remoteConfig.flag, false)
        remoteConfig.setDefaults([\.flag: true])
        XCTAssertEqual(remoteConfig.flag, true)
    }

    func test_optional_bool() {
        XCTAssertEqual(remoteConfig.optionalFlag, false)
        remoteConfig.setDefaults([\.optionalFlag: true])
        XCTAssertEqual(remoteConfig.optionalFlag, true)
    }

    func test_int() {
        XCTAssertEqual(remoteConfig.intNumber, 0)
        remoteConfig.setDefaults([\.intNumber: 2])
        XCTAssertEqual(remoteConfig.intNumber, 2)
    }

    func test_optional_int() {
        XCTAssertEqual(remoteConfig.optionalIntNumber, 0)
        remoteConfig.setDefaults([\.optionalIntNumber: 2])
        XCTAssertEqual(remoteConfig.optionalIntNumber, 2)
    }

    func test_double() {
        XCTAssertEqual(remoteConfig.doubleNumber, 0)
        remoteConfig.setDefaults([\.doubleNumber: 2])
        XCTAssertEqual(remoteConfig.doubleNumber, 2)
    }

    func test_optional_double() {
        XCTAssertEqual(remoteConfig.optionalDoubleNumber, 0)
        remoteConfig.setDefaults([\.optionalDoubleNumber: 2])
        XCTAssertEqual(remoteConfig.optionalDoubleNumber, 2)
    }

    func test_float() {
        XCTAssertEqual(remoteConfig.floatNumber, 0)
        remoteConfig.setDefaults([\.floatNumber: 2])
        XCTAssertEqual(remoteConfig.floatNumber, 2)
    }

    func test_optional_float() {
        XCTAssertEqual(remoteConfig.optionalFloatNumber, 0)
        remoteConfig.setDefaults([\.optionalFloatNumber: 2])
        XCTAssertEqual(remoteConfig.optionalFloatNumber, 2)
    }

    func test_data() {
        XCTAssertEqual(remoteConfig.data, Data())
        remoteConfig.setDefaults([\.data: "foo".data(using: .utf8)!])
        XCTAssertEqual(remoteConfig.data, "foo".data(using: .utf8)!)
    }

    func test_optional_data() {
        XCTAssertEqual(remoteConfig.optionalData, Data())
        remoteConfig.setDefaults([\.optionalData: "foo".data(using: .utf8)!])
        XCTAssertEqual(remoteConfig.optionalData, "foo".data(using: .utf8)!)
    }

    func test_codable() {
        XCTAssertEqual(remoteConfig.animal, .init(id: 0, name: "cat"))
        remoteConfig.setDefaults([\.animal: .init(id: 1, name: "dog")])
        XCTAssertEqual(remoteConfig.animal, .init(id: 1, name: "dog"))
    }

    func test_optional_codable() {
        XCTAssertEqual(remoteConfig.optionalAnimal, nil)
        remoteConfig.setDefaults([\.optionalAnimal: .init(id: 1, name: "dog")])
        XCTAssertEqual(remoteConfig.optionalAnimal, .init(id: 1, name: "dog"))
    }

    func test_rawRepresentable_string() {
        XCTAssertEqual(remoteConfig.fruit, .apple)
        remoteConfig.setDefaults([\.fruit: .orange])
        XCTAssertEqual(remoteConfig.fruit, .orange)
    }

    func test_optional_rawRepresentable_string() {
        XCTAssertEqual(remoteConfig.optionalFruit, nil)
        remoteConfig.setDefaults([\.optionalFruit: .orange])
        XCTAssertEqual(remoteConfig.optionalFruit, .orange)
    }

    func test_rawRepresentable_int() {
        XCTAssertEqual(remoteConfig.number, .one)
        remoteConfig.setDefaults([\.number: .two])
        XCTAssertEqual(remoteConfig.number, .two)
    }

    func test_optinal_rawRepresentable_int() {
        XCTAssertEqual(remoteConfig.optionalNumber, .one)
        remoteConfig.setDefaults([\.optionalNumber: .two])
        XCTAssertEqual(remoteConfig.optionalNumber, .two)
    }

    func test_array_rawRepresentable_string() {
        XCTAssertEqual(remoteConfig.fruitArray, [])
        remoteConfig.setDefaults([\.fruitArray: [.apple, .orange]])
        XCTAssertEqual(remoteConfig.fruitArray, [.apple, .orange])
    }

    func test_int_array() {
        XCTAssertEqual(remoteConfig.intArray, [])
        remoteConfig.setDefaults([\.intArray: [1, 2, 3]])
        XCTAssertEqual(remoteConfig.intArray, [1, 2, 3])
    }

    func test_string_array() {
        XCTAssertEqual(remoteConfig.stringArray, [])
        remoteConfig.setDefaults([\.stringArray: ["1", "2", "3"]])
        XCTAssertEqual(remoteConfig.stringArray, ["1", "2", "3"])
    }

    func test_rawRepresentable_int_array() {
        XCTAssertEqual(remoteConfig.numberArray, [])
        remoteConfig.setDefaults([\.numberArray: [.one, .two]])
        XCTAssertEqual(remoteConfig.numberArray, [.one, .two])
    }

    func test_codable_array() {
        XCTAssertEqual(remoteConfig.animalArray, [])
        remoteConfig.setDefaults([\.animalArray: [.init(id: 1, name: "cat")]])
        XCTAssertEqual(remoteConfig.animalArray, [.init(id: 1, name: "cat")])
    }
}
