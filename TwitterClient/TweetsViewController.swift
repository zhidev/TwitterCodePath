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
    //var refreshControl: UIRefreshControl!
    
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
        
        /*refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)*/
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
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
        }
        return 0
    }
    
    /*
    func refreshControlAction(refreshControl: UIRefreshControl){
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error)->() in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        refreshControl.endRefreshing()
    }*/
}
