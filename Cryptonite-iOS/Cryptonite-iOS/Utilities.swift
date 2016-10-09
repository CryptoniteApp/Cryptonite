//
//  Utilities.swift
//  Cryptonite-iOS
//
//  Created by Andrew Arpasi on 10/9/16.
//  Copyright © 2016 Andrew Arpasi. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    class func getVisibleViewController(rootVC: UIViewController?) -> UIViewController? {
        
        var rootViewController = rootVC
        if rootViewController == nil {
            rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        }
        
        if rootViewController?.presentedViewController == nil {
            return rootViewController
        }
        
        if let presented = rootViewController?.presentedViewController {
            if presented.isKindOfClass(UINavigationController) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKindOfClass(UITabBarController) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
    
    
}
