//
//  AuthenticationManager.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/9/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class AuthenticationManager: NSObject {
    static var currentHex = ""
    static var currentPass = ""
    
    static func validate() -> Bool {
        if(!Database.decrypt(currentHex, pass: currentPass)) {
            currentHex = ""
            currentPass = ""
            return false
        }
        return true
    }
}
