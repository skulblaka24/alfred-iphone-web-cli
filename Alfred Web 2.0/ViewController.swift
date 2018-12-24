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
            override var  preferredStatusBarStyle : UIStatusBarStyle {
    
                return UIStatusBarStyle.lightContent
            }
            override func viewWillAppear(_ animated: Bool) {
                self.navigationController?.isNavigationBarHidden =  true
    
    
            //Status bar style and visibility
                UIApplication.shared.isStatusBarHidden = false
                UIApplication.shared.statusBarStyle = .lightContent
    
            //Change status bar color
                let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
                if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
                    statusBar.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
                    statusBar.tintColor = UIColor.white
                }
            
            }
    
    
        // Gesture handler Swipe
        func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            if (sender.direction == .left) {
                print("Swipe Left")
    
            }
    
            if (sender.direction == .right) {
                print("Swipe Right")
                
               
            }
        }
    
        // Gesture handler LongPress
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        func onLongPress(_ gestureRecognizer:UIGestureRecognizer){
            if gestureRecognizer.state == UIGestureRecognizerState.began {
                NSLog("long press detected")
                let secondViewController:ViewControllerSettings = ViewControllerSettings()
                self.present(secondViewController, animated: true, completion: nil)
            }
        }

    
        // Website
        var webView: WKWebView!
    
        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, cred)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Website Loader
        let website = "https://IP/iphone/page/portail.php"
        //let website = "http://10.201.17.233/iphone/page/control_center.php"
        layoutWebBrowsingElements()
        loadURLRequest(website)
        webView.scrollView.isScrollEnabled = false
        
        // Gesture Recognisor
        let longPressRecognizer = UILongPressGestureRecognizer()
        longPressRecognizer.delegate = self
        longPressRecognizer.addTarget(self, action: #selector(ViewController.onLongPress(_:)))
        self.webView!.scrollView.addGestureRecognizer(longPressRecognizer)
        
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.delegate = self
        leftSwipe.addTarget(self, action: #selector(ViewController.handleSwipes(_:)))
        leftSwipe.direction = .left
        self.webView!.scrollView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.delegate = self
        rightSwipe.addTarget(self, action: #selector(ViewController.handleSwipes(_:)))
        rightSwipe.direction = .right
        self.webView!.scrollView.addGestureRecognizer(rightSwipe)
        
    }
    
    func loadURLRequest(_ address: String) {
        
        webView.navigationDelegate = self
        let url = URL(string: address)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func layoutWebBrowsingElements() {
       
        webView = WKWebView(frame: view.bounds)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto-Layout Stuff
        self.view.addSubview(webView)
        
        
        let webTopSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .topMargin, relatedBy: .equal, toItem: webView, attribute: .top, multiplier: 1, constant: -20)
        let webBottomSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .bottomMargin, relatedBy: .equal, toItem: webView, attribute: .bottom, multiplier: 1, constant: 0)
        let webLeadingSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .leadingMargin, relatedBy: .equal, toItem: webView, attribute: .leading, multiplier: 1, constant: 20)
        
        let webTrailingSpaceToContainer = NSLayoutConstraint(item: self.view, attribute: .trailingMargin, relatedBy: .equal, toItem: webView, attribute: .trailing, multiplier: 1, constant: -20)
        
        let webViewConstaints = [webTopSpaceToContainer,webBottomSpaceToContainer,webLeadingSpaceToContainer,webTrailingSpaceToContainer]
        
        self.view.addConstraints(webViewConstaints)
        
    }
}


