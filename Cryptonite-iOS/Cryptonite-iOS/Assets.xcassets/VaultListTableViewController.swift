//
//  VaultListTableViewController.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/9/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class VaultListTableViewController: UITableViewController {

    @IBOutlet var syncBtn: UIBarButtonItem!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = syncBtn
        self.navigationItem.title = "My Vault"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotif:", name: "unlockSuccessNotif", object: nil)
    }
    
    func receiveNotif(notif: NSNotification) {
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        if(!Database.decrypted) {
            self.performSegueWithIdentifier("authSegue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sync(sender: AnyObject) {
        self.performSegueWithIdentifier("syncSegue", sender: sender)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Database.websiteJSON.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("accountCell", forIndexPath: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let subTitleLabel = cell.viewWithTag(2) as! UILabel
        
        titleLabel.text = Database.getWebsiteDetailAtIndices(indexPath.row, b: 0) as! String
        subTitleLabel.text = Database.getWebsiteDetailAtIndices(indexPath.row, b: 1) as! String
        
        if(titleLabel.text == "pornhub")
        {
            titleLabel.text = "Yahoo"
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("websiteDetailsView") as! EditWebsiteViewController
        vc.websiteIndex = indexPath.row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.presentViewController(vc, animated: true, completion: {() in })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "websiteSegue") {
            let destination = segue.destinationViewController as! EditWebsiteViewController
            destination.websiteIndex = selectedIndex
        }
    }
    

}
