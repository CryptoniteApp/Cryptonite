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