//
//  EditWebsiteViewController.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/9/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class EditWebsiteViewController: UIViewController {

    var websiteIndex: Int = 0
    
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("WEBSITE INDEX: " + String(websiteIndex))
        websiteField.text = Database.getWebsiteDetailAtIndices(websiteIndex, b: 0)
        usernameField.text = Database.getWebsiteDetailAtIndices(websiteIndex, b: 1)
        passwordField.text = Database.getWebsiteDetailAtIndices(websiteIndex, b: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func revealStart(sender: AnyObject) {
        passwordField.secureTextEntry = false
    }
    
    @IBAction func revealStop(sender: AnyObject) {
        passwordField.secureTextEntry = true
    }
    
    @IBAction func done(sender: AnyObject) {
        Database.setWebsiteDetailAtIndices(websiteIndex, b: 0, detail: websiteField.text!)
        Database.setWebsiteDetailAtIndices(websiteIndex, b: 1, detail: usernameField.text!)
        Database.setWebsiteDetailAtIndices(websiteIndex, b: 2, detail: passwordField.text!)
        Database.writeDatabase(AuthenticationManager.currentHex, pass: AuthenticationManager.currentPass)
        Database.decrypt(AuthenticationManager.currentHex, pass: AuthenticationManager.currentPass)
        NSNotificationCenter.defaultCenter().postNotificationName("unlockSuccessNotif", object: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
