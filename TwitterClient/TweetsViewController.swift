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
    var refreshControl: UIRefreshControl!
    
    //var isMoreDataLoading = false
    
    //var loadMoreOffset = 20
    
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
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
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
            print("/////////////////TWEETS : \(tweets.count) /////////////////")
            return tweets.count
        }
        return 0
    }
    
    

    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // Make network request to fetch latest data
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion:  { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        refreshControl.endRefreshing()
    }
    //Infinite scroll
/*    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                loadMoreData()
            }
            
        }
    }
    

    func loadMoreData(){

        
        let twitterApiMore = ["since_id":self.loadMoreOffset, "count": 20 ]
        TwitterClient.sharedInstance.homeTimelineWithParams(twitterApiMore, completion: { (tweets, error) ->() in
            if error != nil{
                print("LOAD MORE DATA ERROR")
            }else{
                print("LOADING DATA")
                self.delay(0.5, closure: { Void in
                    self.loadMoreOffset += 20
                    self.tweets?.appendContentsOf(tweets!)
                    self.tableView.reloadData()
                    self.isMoreDataLoading = false
                })
            }
        })
        
        
    }
    func delay(delay: Double, closure: () -> () ) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure
        )
    }*/
    
}
