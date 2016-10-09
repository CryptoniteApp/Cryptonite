//
//  PasswordViewController.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class AuthPasswordViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unlock(sender: AnyObject) {
        AuthenticationManager.currentPass = passwordField.text!
        if AuthenticationManager.validate() {
            self.dismissViewControllerAnimated(true, completion: {() in
                NSNotificationCenter.defaultCenter().postNotificationName("unlockSuccessNotif", object: nil)
            })
        } else {
            self.dismissViewControllerAnimated(true, completion: {() in
                NSNotificationCenter.defaultCenter().postNotificationName("unlockFailNotif", object: nil)
            })
        }
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
