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
    }
    
    
    
    @IBAction func favorite(sender: AnyObject) {
    }
    
    
    
}
