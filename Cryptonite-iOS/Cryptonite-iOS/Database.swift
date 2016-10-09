//
//  Database.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class Database {
    
    static var decryptedJSON = ""
    
    static func writeDatabase(hex: String, pass: String) {
        let aes = AESHelper(key: ProceduralHelper.generateHash(hex,pass: pass), iv: ProceduralHelper.generateIV(hex,pass: pass))
        let encrypted = aes.encrypt(decryptedJSON)
        decryptedJSON = ""
        NSUserDefaults.standardUserDefaults().setObject(encrypted, forKey: "database")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func loadEncryptedData() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("database") as? String
    }
    
    static func decrypt(hex: String, pass: String) {
        let encrypted = loadEncryptedData()
        let aes = AESHelper(key: ProceduralHelper.generateHash(hex,pass: pass), iv: ProceduralHelper.generateIV(hex,pass: pass))
        decryptedJSON = aes.decrypt(encrypted!)
        print(decryptedJSON)
    }
    
    static func addWebsite(name: String,user: String,password: String) {
        
    }
    
}
