//
//  ViewControllerSettings.swift
//  Alfred Web 2.0
//
//  Created by Gauthier Donikian on 18/05/2016.
//  Copyright © 2016 Alfred. All rights reserved.
//

import UIKit
import WebKit
import SafariServices



class ViewControllerSettings: UIViewController, WKNavigationDelegate {
    
    @IBAction func exitBtn (sender: AnyObject) {
        
        let secondViewController:ViewController = ViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    @IBAction func clearCache (sender: AnyObject) {
        
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = NSDate(timeIntervalSince1970: 0)
        WKWebsiteDataStore.defaultDataStore().removeDataOfTypes(websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
    @IBAction func refresh (sender: AnyObject) {
        
        let secondViewController:ViewController = ViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    // Status Bar Customizer
    override func  preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.Default
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden =  true
        
        
        //Status bar style and visibility
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        //Change status bar color
        let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
        if statusBar.respondsToSelector(Selector("setBackgroundColor:")) {
            statusBar.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
