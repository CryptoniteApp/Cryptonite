//
//  ProceduralHelper.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class ProceduralHelper {
    static func generateFullHash(hex: String, pass: String) -> String {
        var rawSeed = hex
        
        var seed: Int = 0
        print("Pass: " + pass + " Hex: " + hex)
        
        for i in 0...pass.characters.count-1 {
            
            let ch: Character = pass[i]
            seed += Int(ch.asciiValue!)
        }
        
        seed = Int(pow(Double(seed),4.0))
        
        var nums = Array(String(seed).characters)
        
        for i in 0...nums.count-1 {
            let pos1 = Int(String(nums[i]))
            let pos2 = Int(String(nums[pos1!]))
            let temp = nums[pos1!];
            nums[pos1!] = nums[pos2!]
            nums[pos2!] = temp
        }
        
        for a in nums {
            let n = Int(String(a))
            rawSeed = rawSeed.insert(String(Character(UnicodeScalar((65+n!)))), ind: n!)
        }
        
        print(rawSeed)
        
        let hashedStringRaw = sha256(rawSeed.dataUsingEncoding(NSASCIIStringEncoding)!)
        
        return hashedStringRaw
        
    }
    
    static func generateIV(hex: String, pass: String) -> String {
        var hashedStringRaw = generateFullHash(hex, pass: pass)
        
        hashedStringRaw = hashedStringRaw.stringByReplacingOccurrencesOfString("<", withString: "")
        hashedStringRaw = hashedStringRaw.stringByReplacingOccurrencesOfString(">", withString: "")
        
        let hashedString = hashedStringRaw.substringFromIndex(hashedStringRaw.endIndex.advancedBy(-16))
                
        return hashedString
    }
    
    static func generateHash(hex: String, pass: String) -> String {
        var hashedStringRaw = generateFullHash(hex, pass: pass)
        
        hashedStringRaw = hashedStringRaw.stringByReplacingOccurrencesOfString("<", withString: "")
        hashedStringRaw = hashedStringRaw.stringByReplacingOccurrencesOfString(">", withString: "")
        
        let hashedString = hashedStringRaw.substringToIndex(hashedStringRaw.startIndex.advancedBy(32))
        
        return hashedString
    }
    
    static func sha256(data : NSData) -> String {
        
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        
        CC_SHA256(data.bytes, CC_LONG(data.length), UnsafeMutablePointer(res!.mutableBytes))
        
        // There is a better way to do this .... but this is a quick hack
        
        return "\(res!)".stringByReplacingOccurrencesOfString("", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
        
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII()}.map{$0.value}
    }
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII()}.first?.value
    }
}