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
        
        //set our nav title to user's screen name
        self.navigationItem.title = User.currentUser?.screenName
        
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) ->() in
            self.tweets = tweets
            self.tableView.reloadData()
            //Update tableview when we get tweets to populate our tableView
        })
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
        let display = tweets![indexPath.row]
        cell.tweetView.text = display.text
        cell.tweetPic.setImageWithURL( (NSURL(string: (display.user?.profileImageURL!)!))! )
        cell.nameLabel.text = display.user?.name
        let usernameText = "@" + (display.user?.screenName)!
        cell.usernameLabel.text =  (usernameText)
        cell.timeLabel.text = cell.calculateTimestamp(display.createdAt!.timeIntervalSinceNow)
        
        
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    

}
