//
//  TweetsTableViewCell.swift
//  TwitterClient
//
//  Created by Douglas on 2/14/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet var tweetPic: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tweetView: UITextView!
    @IBOutlet var timeLabel: UILabel!
    
    
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var retweetCount: UILabel!
    @IBOutlet var favoriteCount: UILabel!
    
    
    
    
    var tweetID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tweetPic.layer.cornerRadius = 3
        tweetPic.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var tweet: Tweet! {
        didSet{
            tweetView.text = tweet.text
            tweetPic.setImageWithURL( (NSURL(string: (tweet.user?.profileImageURL!)!))! )
            nameLabel.text = tweet.user?.name
            let usernameText = "@" + (tweet.user?.screenName)!
            usernameLabel.text =  (usernameText)
            timeLabel.text = calculateTimestamp(tweet.createdAt!.timeIntervalSinceNow)
            
            
            tweetID = tweet.id
            retweetCount.text = String(tweet.retweetCount)
            favoriteCount.text = String(tweet.heartCount)
            
            
            
            retweetCount.text! == "0" ? (retweetCount.hidden = true) : (retweetCount.hidden = false)
            favoriteCount.text! == "0" ? (favoriteCount.hidden = true) : (favoriteCount.hidden = false)
            
            retweetCount.text! = retweetCount.text!
            favoriteCount.text! = favoriteCount.text!
        }
    }
    
    

    func calculateTimestamp(tweetTime: NSTimeInterval) -> String {
        //Turn tweetTime into sec, min, hr , days, yrs
        var time = Int(tweetTime)
        var timeAgo = 0
        var timeChar = ""
        
        time = time*(-1)
        
        // Find time ago
        if (time <= 60) { // SECONDS
            timeAgo = time
            timeChar = "sec"
        } else if ((time/60) <= 60) { // MINUTES
            timeAgo = time/60
            timeChar = "min"
        } else if (time/60/60 <= 24) { // HOURS
            timeAgo = time/60/60
            timeChar = "hr"
        } else if (time/60/60/24 <= 365) { // DAYS
            timeAgo = time/60/60/24
            timeChar = "day"
        } else if (time/(3153600) <= 1) { // YEARS
            timeAgo = time/60/60/24/365
            timeChar = "yr"
        }
        //format string
        return "\(timeAgo)\(timeChar) ago"
    }
    
    @IBAction func retweet(sender: AnyObject) {
        print("///////////////retweet button clicked/////////////////")
        TwitterClient.sharedInstance.retweet(Int(tweetID!)!, params: nil, completion: { (error)->() in


            print("////////////retweet func being called from within tableviewcell///////////")
            let data = NSUserDefaults.standardUserDefaults().boolForKey(change)
            if data{
                if self.retweetCount.text! > "0"{
                    self.retweetCount.text = String(self.tweet.retweetCount + 1)
                }else{
                    self.retweetCount.hidden = false
                    self.retweetCount.text = String(self.tweet.retweetCount + 1)
                }
            }
            
            
        })//end retweet
    }//end retweet func
    
    
    
    @IBAction func favorite(sender: AnyObject) {
        print("///////////////favorite button clicked//////")
        TwitterClient.sharedInstance.favorited(Int(tweetID!)!, params: nil, completion: {(error) -> () in
            print("//////FAVORITED/////////")


                if self.favoriteCount.text! > "0" {
                    self.favoriteCount.text = String(self.tweet.heartCount + 1)
                }else{
                    self.favoriteCount.hidden = false
                    self.favoriteCount.text = String(self.tweet.heartCount + 1)
                }
            
        
        })
    
    
    }
    
    
    
}
