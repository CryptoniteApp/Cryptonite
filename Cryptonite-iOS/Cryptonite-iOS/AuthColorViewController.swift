//
//  AuthColorViewController.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class AuthColorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var colorCollection: UICollectionView!
    @IBOutlet weak var progressIndicator: UIProgressView!
    
    var selectedHexStr = ""
    var selectedHexCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotif:", name: "unlockSuccessNotif", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotif:", name: "unlockFailNotif", object: nil)
        Database.decryptedJSON = "[ [ \"reddit\", \"herp@derp.com\", \"password\" ], [ \"pornhub\", \"lenny@face.com\", \"lenny\" ], [\"spexy\", \"reddit\", \"poop\"] ]"
        Database.writeDatabase("#2980B9#2980B9#27AE60#27AE60#E67E22#E67E22", pass: "MrKrabs@123")
        let dsi = DesktopServerInteractor()
        print(Database.loadEncryptedData())
        dsi.serverURL = "http://192.168.43.179:4200"
        //dsi.combineRequest()
        progressIndicator.progress = 0
        
        
    /*NSUserDefaults.standardUserDefaults().setObject("c68b01c04829c48edaf865f88e742f45b2f1322fcf8d33556ce3de02600fa3e12712adf7744cc33bd8b739c294f278e08c5a75ed61ef9202172919a766281ddee56433aca5ee2d2b438c51740d4bbe7181e04117609dd7225a1fd722f1ab5a7b629da6a8ac8eeeda68e0dc51a13da2fd8c69044ea7fe031b9e4e8060088df897", forKey: "database")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        Database.decrypt("#2980B9#2980B9#27AE60#27AE60#E67E22#E67E22", pass: "MrKrabs@123")
                */
        // Do any additional setup after loading the view.
    }
    
    func receiveNotif(notif: NSNotification) {
        if(notif.name == "unlockFailNotif") {
            selectedHexStr = ""
            selectedHexCount = 0
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 11
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colorCell", forIndexPath: indexPath)
        
        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 4
        
        if(indexPath.row == 9) {
            cell.layer.borderColor = UIColor.clearColor().CGColor
        }
        else if(indexPath.row > 9) {
            cell.layer.borderColor = Color.colors[indexPath.row-1].getUIColor().CGColor
        }
        else {
            cell.layer.borderColor = Color.colors[indexPath.row].getUIColor().CGColor
        }
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
     // Uncomment this method to specify if the specified item should be selected
     /*override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }*/
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedHexCount += 1
        
        
        progressIndicator.progress = Float(selectedHexCount) / 6
        if(indexPath.row > 9) {
            selectedHexStr = selectedHexStr + Color.colors[indexPath.row-1].hexStr
        }
        else {
            selectedHexStr = selectedHexStr + Color.colors[indexPath.row].hexStr
        }
        
        print(selectedHexStr)
        
        if(selectedHexCount == 6) {
            AuthenticationManager.currentHex = selectedHexStr
            self.performSegueWithIdentifier("unlockVaultSegue", sender: self)
        }
    }
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
