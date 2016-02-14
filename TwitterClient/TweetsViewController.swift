//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Douglas on 2/13/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) ->() in
            self.tweets = tweets
            self.tableView.reloadData()
            print("&%&&%&%&&%&%&%&%&%&&%&%&%&%&%&&%&%&%&%&%&&%")
            print("Tweets: \(tweets)")

        })
        print("Tweets: \(tweets)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetsTableViewCell
        cell.tweetView.text = tweets![indexPath.row].text
        //print(tweets![indexPath.row].text)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    

}
