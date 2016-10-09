//
//  Color.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/9/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class Color {
    var hexStr = ""
    var actualHex: String = "FFFFFF"
    
    init(actualHex: String, hexStr: String) {
        self.hexStr = hexStr
        self.actualHex = actualHex
    }
    
    static let colors = [Color(actualHex: "2980B9",hexStr: "#2980B9".uppercaseString),
                         Color(actualHex: "27AE60",hexStr: "#27AE60".uppercaseString),
                         Color(actualHex: "E67E22",hexStr: "#E67E22".uppercaseString),
                         Color(actualHex: "8E44AD",hexStr: "#8E44AD".uppercaseString),
                         Color(actualHex: "2C3E50",hexStr: "#2C3E50".uppercaseString),
                         Color(actualHex: "F1C40F",hexStr: "#F1C40F".uppercaseString),
                         Color(actualHex: "E62C19",hexStr: "#E62C19".uppercaseString),
                         Color(actualHex: "7F8C8D",hexStr: "#7F8C8D".uppercaseString),
                         Color(actualHex: "ED7EED",hexStr: "#ED7EED".uppercaseString),
                         Color(actualHex: "ECF0F1",hexStr: "#ECF0F1".uppercaseString)]
    
    func getUIColor() -> UIColor {
        return UIColor(hexString: actualHex)
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}