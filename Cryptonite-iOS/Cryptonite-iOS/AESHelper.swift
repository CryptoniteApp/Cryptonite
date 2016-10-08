//
//  AESHelper.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/7/16.
//  Not actually created by me though, copy and pasted from some website
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import CryptoSwift

class AESHelper {
    
    var key: String
    var iv: String
    let BLOCK_SIZE = 16
    
    init (key: String, iv: String) {
        self.key = key
        self.iv = iv
    }
    
    func encrypt (stringToEncrypt: String) -> String {
        let messageData = stringToEncrypt.dataUsingEncoding(NSUTF8StringEncoding)
        let byteArray = pad(messageData!.arrayOfBytes())
        let encryptedBytes = try! AES(key: self.key, iv: self.iv, blockMode: .CFB).encrypt(byteArray)
        return encryptedBytes.toHexString()
    }
    
    func decrypt ( message: String) -> String {
        let messageData = message.dataFromHexadecimalString()
        let byteArray = messageData?.arrayOfBytes()
        let decryptedBytes: [UInt8] = try! AES(key: self.key, iv: self.iv, blockMode: .CFB).decrypt(byteArray!)
        let unpaddedBytes = unpad(decryptedBytes)
        let unencryptedString = NSString(bytes: unpaddedBytes, length: unpaddedBytes.count, encoding: NSUTF8StringEncoding)
        return String(unencryptedString)
    }
    
    private func pad(val: [UInt8]) -> [UInt8] {
        var value = val
        let length: Int = value.count
        let padSize = BLOCK_SIZE - (length % BLOCK_SIZE)
        let padArray = [UInt8](count: padSize, repeatedValue: 0)
        value.appendContentsOf(padArray)
        return value
    }
    
    private func unpad(val: [UInt8]) -> [UInt8] {
        var value = val;
        for var index = value.count - 1; index >= 0; index -= 1 {
            if value[index] == 0 {
                value.removeAtIndex(index)
            } else  {
                break
            }
        }
        return value
    }
    
}

extension String {
    
    /// http://stackoverflow.com/questions/26501276/converting-hex-string-to-nsdata-in-swift
    ///
    /// Create NSData from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a NSData object. Note, if the string has any spaces, those are removed. Also if the string started with a '<' or ended with a '>', those are removed, too. This does no validation of the string to ensure it's a valid hexadecimal string
    ///
    /// The use of `strtoul` inspired by Martin R at http://stackoverflow.com/a/26284562/1271826
    ///
    /// - returns: NSData represented by this hexadecimal string. Returns nil if string contains characters outside the 0-9 and a-f range.
    
    func dataFromHexadecimalString() -> NSData? {
        let trimmedString = self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<> ")).stringByReplacingOccurrencesOfString(" ", withString: "")
        
        // make sure the cleaned up string consists solely of hex digits, and that we have even number of them
        
        let regex = try! NSRegularExpression(pattern: "^[0-9a-f]*$", options: .CaseInsensitive)
        
        let found = regex.firstMatchInString(trimmedString, options: [], range: NSMakeRange(0, trimmedString.characters.count))
        if found == nil || found?.range.location == NSNotFound || trimmedString.characters.count % 2 != 0 {
            return nil
        }
        
        // everything ok, so now let's build NSData
        
        let data = NSMutableData(capacity: trimmedString.characters.count / 2)
        
        for var index = trimmedString.startIndex; index < trimmedString.endIndex; index = index.successor().successor() {
            let byteString = trimmedString.substringWithRange(Range<String.Index>(start: index, end: index.successor().successor()))
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
            data?.appendBytes([num] as [UInt8], length: 1)
        }
        
        return data
    }
}