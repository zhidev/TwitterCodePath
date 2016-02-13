//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Douglas on 2/13/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    
    @IBOutlet var logoutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
    }

}
