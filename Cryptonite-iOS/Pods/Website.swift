//
//  Website.swift
//  Pods
//
//  Created by Andrew Arpasi on 10/8/16.
//
//

import UIKit
import SwiftyJSON

class Website {
    var name: String
    var user: String
    var password: String
    
    init(name: String, user: String, password: String) {
        self.name = name
        self.user = user
        self.password = password
    }
    
    func getJSONArrayItemRawString() -> String {
        return "['" + name + "','" + user + "','" + password + "']"
    }
    
    func getArrayItem() -> JSON {
        return [name,user,password]
    }
}