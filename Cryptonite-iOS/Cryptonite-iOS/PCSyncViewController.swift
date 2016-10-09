//
//  PCSyncViewController.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/8/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation

class PCSyncViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    lazy var readerVC = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanQR(sender: AnyObject) {
        readerVC.delegate = self
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result?.value)
            if(result != nil)
            {
                if result?.value.containsString(":4200") != nil {
                    let dsi = DesktopServerInteractor()
                    let results = result?.value.characters.split{$0 == "/"}.map(String.init)
                    dsi.serverURL = results![0]
                    if(results![1].containsString("combine")){
                        dsi.combineRequest()
                    } else if(results![1].containsString("phonetopc")){
                        dsi.sendPhoneReplaceDesktopRequest()
                    }
                } else if result?.value.containsString("replace:") != nil {
                    let encryptedData = result?.value.stringByReplacingOccurrencesOfString("replace:", withString: "")
                    Database.updateDatabaseEncryptedContent(encryptedData!, hex: AuthenticationManager.currentHex, pass: AuthenticationManager.currentPass)
                }
            }
            
        }
        
        readerVC.modalPresentationStyle = .FormSheet
        presentViewController(readerVC, animated: true, completion: nil)
    }
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
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
