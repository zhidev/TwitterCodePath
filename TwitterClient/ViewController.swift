//
//  ViewController.swift
//  TwitterClient
//
//  Created by Douglas on 2/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        //®TwitterClient.sharedInstance.loginWithBlock()
        
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { ( requestToken: BDBOAuth1Credential!) -> Void in
            print("got request token")
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error:NSError!) -> Void in
                print("failed to get request token")
        }
    }

}

