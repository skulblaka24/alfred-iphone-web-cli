//
//  ViewController.swift
//  Alfred Web 2.0
//
//  Created by Gauthier Donikian on 16/05/2016.
//  Copyright © 2016 Alfred. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

//                            #######    Version qui cache la status barre en noir    ##########

class ViewController: UIViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {
    
    
        // Status Bar Customizer
            override func  preferredStatusBarStyle() -> UIStatusBarStyle {
    
                return UIStatusBarStyle.LightContent
            }
            override func viewWillAppear(animated: Bool) {
                self.navigationController?.navigationBarHidden =  true
    
    
            //Status bar style and visibility
                UIApplication.sharedApplication().statusBarHidden = false
                UIApplication.sharedApplication().statusBarStyle = .LightContent
    
            //Change status bar color
                let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
                if statusBar.respondsToSelector(Selector("setBackgroundColor:")) {
                    statusBar.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
                    statusBar.tintColor = UIColor.whiteColor()
                }
            
            }
    
    
        // Gesture handler Swipe
        func handleSwipes(sender:UISwipeGestureRecognizer) {
            if (sender.direction == .Left) {
                print("Swipe Left")
    
            }
    
            if (sender.direction == .Right) {
                print("Swipe Right")
                
               
            }
        }
    
        // Gesture handler LongPress
        func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        func onLongPress(gestureRecognizer:UIGestureRecognizer){
            if gestureRecognizer.state == UIGestureRecognizerState.Began {
                NSLog("long press detected")
                let secondViewController:ViewControllerSettings = ViewControllerSettings()
                self.presentViewController(secondViewController, animated: true, completion: nil)
            }
        }

    
        // Website
        var webView: WKWebView!
    
        func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge,
                 completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
            let cred = NSURLCredential.init(forTrust: challenge.protectionSpace.serverTrust!)
            completionHandler(.UseCredential, cred)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Website Loader
        let website = "https://81.57.93.49:4000/iphone/page/dashboard.php"
        layoutWebBrowsingElements()
        loadURLRequest(website)
        webView.scrollView.scrollEnabled = false
        
        // Gesture Recognisor
        let longPressRecognizer = UILongPressGestureRecognizer()
        longPressRecognizer.delegate = self
        longPressRecognizer.addTarget(self, action: #selector(ViewController.onLongPress(_:)))
        self.webView!.scrollView.addGestureRecognizer(longPressRecognizer)
        
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.delegate = self
        leftSwipe.addTarget(self, action: #selector(ViewController.handleSwipes(_:)))
        leftSwipe.direction = .Left
        self.webView!.scrollView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.delegate = self
        rightSwipe.addTarget(self, action: #selector(ViewController.handleSwipes(_:)))
        rightSwipe.direction = .Right
        self.webView!.scrollView.addGestureRecognizer(rightSwipe)
        
    }
    
    func loadURLRequest(address: String) {
        
        webView.navigationDelegate = self
        let url = NSURL(string: address)!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func layoutWebBrowsingElements() {
       
        webView = WKWebView(frame: view.bounds)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto-Layout Stuff
        self.view.addSubview(webView)
        
        
        let webTopSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .TopMargin, relatedBy: .Equal, toItem: webView, attribute: .Top, multiplier: 1, constant: -20)
        let webBottomSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .BottomMargin, relatedBy: .Equal, toItem: webView, attribute: .Bottom, multiplier: 1, constant: 0)
        let webLeadingSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .LeadingMargin, relatedBy: .Equal, toItem: webView, attribute: .Leading, multiplier: 1, constant: 20)
        
        let webTrailingSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: webView, attribute: .Trailing, multiplier: 1, constant: -20)
        
        let webViewConstaints = [webTopSpaceToContainer,webBottomSpaceToContainer,webLeadingSpaceToContainer,webTrailingSpaceToContainer]
        
        self.view.addConstraints(webViewConstaints)
        
    }
}


