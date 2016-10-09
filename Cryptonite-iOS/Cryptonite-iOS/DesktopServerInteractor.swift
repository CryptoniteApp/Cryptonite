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
        })
    }
    
    func sendPhoneReplaceDesktopRequest() {
        performTextBasedRequestToServer("/phonetopc", method: "POST", body: Database.loadEncryptedData()!, callback: {data,res,error in
            if(data != nil) {
                self.handleServerResponse(String(data: data!, encoding: NSUTF8StringEncoding)!)
            }
        })
    }
    
    func handleServerResponse(dataStr: String) {
        print("==server response==")
        print(dataStr)
        if dataStr != "true" {
            Database.updateDatabaseEncryptedContent(dataStr, hex: AuthenticationManager.currentHex, pass: AuthenticationManager.currentPass)
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
