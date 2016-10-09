//
//  DesktopServerInteractor.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class DesktopServerInteractor {
    
    var serverURL = ""
    
    func combineRequest() {
        performTextBasedRequestToServer("/combine", method: "POST", body: Database.loadEncryptedData()!, callback: {data,res,error in
            if(data != nil) {
                self.handleServerResponse(String(data: data!, encoding: NSUTF8StringEncoding)!)
            }
            self.performTextBasedRequestToServer("/choice", method: "POST", body: "33", callback: {data,res,error in
                print(data)
            })
        })
        
    }
    
    func sendPhoneReplaceDesktopRequest() {
        performTextBasedRequestToServer("/phonetopc", method: "POST", body: Database.loadEncryptedData()!, callback: {data,res,error in
            if(data != nil) {
                self.handleServerResponse(String(data: data!, encoding: NSUTF8StringEncoding)!)
            }
            self.performTextBasedRequestToServer("/choice", method: "POST", body: "22", callback: {data,res,error in
                print(data)
            })
        })
        
    }
    
    func handleServerResponse(dataStr: String) {
        print("==server response==")
        print(dataStr)
        if dataStr != "true" {
            Database.updateDatabaseEncryptedContent(dataStr, hex: "#2980B9#2980B9#27AE60#27AE60#E67E22#E67E22", pass: "MrKrabs@123")
            if(Database.decrypt("#2980B9#2980B9#27AE60#27AE60#E67E22#E67E22", pass: "MrKrabs@123")){
                print("decrypt success:")
                print(Database.decryptedJSON)
            }
        }
    }
    
    func performTextBasedRequestToServer(route: String, method: String, body: String, callback: (NSData?, NSURLResponse?, NSError?) -> Void)
    {
        let url = NSURL(string: serverURL + route)
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            print("==request==")
            if data != nil
            {
                print(String(data: data!, encoding: NSUTF8StringEncoding))
                callback(data,response,error)
            }
            else
            {
                print("data nil")
            }
        }
        task.resume()
    }
}
