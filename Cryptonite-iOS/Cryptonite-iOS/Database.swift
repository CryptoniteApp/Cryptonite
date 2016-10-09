//
//  Database.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import SwiftyJSON

class Database {
    
    static var decryptedJSON = "[]"
    static var websiteJSON: [JSON] = [JSON]()
    
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
    
    static func decrypt(hex: String, pass: String) -> Bool {
        let encrypted = loadEncryptedData()
        print("decrypt hex: " + hex + " pass: " + pass)
        let aes = AESHelper(key: ProceduralHelper.generateHash(hex,pass: pass), iv: ProceduralHelper.generateIV(hex,pass: pass))
        decryptedJSON = aes.decrypt(encrypted!)
        if(decryptedJSON.hasPrefix("Optional(")) {
            decryptedJSON = decryptedJSON.stringByReplacingOccurrencesOfString("Optional(", withString: "")
            decryptedJSON = decryptedJSON.substringToIndex(decryptedJSON.endIndex.predecessor())
        }
        if(decryptedJSON.hasPrefix("[")) {
            websiteJSON = JSON(data: decryptedJSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!).array!
            decryptedJSON = websiteJSON.description
            return true
        } else {
            return false
        }
    }
    
    static func saveWebsite(name: String,user: String,password: String) {
        let website = Website(name: name, user: user, password: password)
        websiteJSON.append(website.getArrayItem())
        decryptedJSON = websiteJSON.description
        print(decryptedJSON)
    }
    
    static func updateDatabaseEncryptedContent(encrypted: String, hex: String, pass: String) {
        let aes = AESHelper(key: ProceduralHelper.generateHash(hex,pass: pass), iv: ProceduralHelper.generateIV(hex,pass: pass))
        var decryptedContent = aes.decrypt(encrypted)
        decryptedContent = decryptedContent.stringByReplacingOccurrencesOfString("Optional(", withString: "")
        decryptedContent = decryptedContent.substringToIndex(decryptedContent.endIndex.predecessor())
        if(decryptedContent.hasPrefix("[")) {
            NSUserDefaults.standardUserDefaults().setObject(encrypted, forKey: "database")
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            print("doesn't work " + decryptedContent)
        }
    }
    
}
