//
//  FirebaseSetUp.swift
//
//
//  Created by nakazawa fumito on 2021/03/28.
//

import Firebase

final class FirebaseSetUp {
    static let shared = FirebaseSetUp()

    init() {
        let bundle: Bundle
        #if SWIFT_PACKAGE
            bundle = Bundle.module
        #else
            bundle = Bundle(for: type(of: self))
        #endif
        let path = bundle.path(forResource: "GoogleService-Info", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: path)!
        FirebaseApp.configure(options: options)
    }
}
