//
//  Website.swift
//  Pods
//
//  Created by Andrew Arpasi on 10/8/16.
//
//

import UIKit

class Website {
    var name: String
    var user: String
    var password: String
    
    init(name: String, user: String, password: String) {
        self.name = name
        self.user = user
        self.password = password
    }
    
    func getJSONArrayItemString() -> String {
        return "['" + name + "','" + user + "','" + password + "']"
    }
}