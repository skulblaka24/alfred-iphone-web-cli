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
    
    @IBAction func exitBtn (_ sender: AnyObject) {
        
        let secondViewController:ViewController = ViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }
    @IBAction func clearCache (_ sender: AnyObject) {
        
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
    @IBAction func refresh (_ sender: AnyObject) {
        
        let secondViewController:ViewController = ViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    // Status Bar Customizer
    override var  preferredStatusBarStyle : UIStatusBarStyle {
        
        return UIStatusBarStyle.default
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  true
        
        
        //Status bar style and visibility
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .default
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
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
