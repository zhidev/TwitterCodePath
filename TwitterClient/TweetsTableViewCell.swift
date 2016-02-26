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
            
            
            //============ testing passive button colors================
            print("+++++++++++++++++\(tweet.text!)+++++++")
            print("+++++++++++++++++\(tweet.didRetweet)+++++++")
            print("+++++++++++++++++\(tweet.didFavorite)+++++++")

            if(tweet.didRetweet){
                print("RETWEET COLORED")
                self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action-on-green.jpg"), forState: UIControlState.Normal)
            }else{
                self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action_default.jpg"), forState: UIControlState.Normal)
            }//end retweet
            if(tweet.didFavorite){
                print("FAVORITE COLORED")
                self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-on-red.jpg"), forState: UIControlState.Normal)
            }else{
                self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-off.jpg"), forState: UIControlState.Normal)
            }//end favorite
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
        if(!self.tweet.didRetweet){ //if it didnt retweet yet
            TwitterClient.sharedInstance.retweet(Int(tweetID!)!, params: nil, completion: { (error)->() in


            print("////////////retweet func being called from within tableviewcell///////////")
            //if(!self.tweet.didRetweet){
                let data = NSUserDefaults.standardUserDefaults().boolForKey(rchange)
                if data{
                    if self.retweetCount.text! > "0"{
                        self.retweetCount.text = String(self.tweet.retweetCount + 1)
                    }else{
                        self.retweetCount.hidden = false
                        self.retweetCount.text = String(self.tweet.retweetCount + 1)
                    }
                    self.tweet.didRetweet = !self.tweet.didRetweet
                    self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action-on-green.jpg"), forState: UIControlState.Normal)
                }//end if data
                
            //}
            
            
            })//end retweet
        }else{//end if loop for didRetweet
            //deleting a retweet
            TwitterClient.sharedInstance.unretweet(Int(tweetID!)!, params: nil, completion: { (error)->() in
                if self.tweet.retweetCount > 1{
                    self.retweetCount.text = String(self.tweet.retweetCount - 1)
                }else{//end if retweet count >1
                //else only 1 retweet (users) so hide everything
                    self.retweetCount.hidden = true
                    self.retweetCount.text = String(self.tweet.retweetCount - 1)
                
                }
            })
            self.tweet.didRetweet = !self.tweet.didRetweet

            self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action_default.jpg"), forState: UIControlState.Normal)
        }
    }//end retweet func
    
    
    
    @IBAction func favorite(sender: AnyObject) {
        print("///////////////favorite button clicked//////")
        if(!self.tweet.didFavorite){
        TwitterClient.sharedInstance.favorited(Int(tweetID!)!, params: nil, completion: {(error) -> () in
            print("//////FAVORITED/////////")

            //if(!self.tweet.didFavorite){ //if they did favorite then this shouldnt run because its already favorited,
                //else increment
                if self.tweet.heartCount > 0 {
                    self.favoriteCount.text = String(self.tweet.heartCount + 1)
                }else{
                    self.favoriteCount.hidden = false
                    self.favoriteCount.text = String(self.tweet.heartCount + 1)
                }
            self.tweet.didFavorite = !self.tweet.didFavorite
            self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-on-red.jpg"), forState: UIControlState.Normal)
                //print("+++++++++++++++++\(self.tweet.text)+++++++")

            //}
        
        })
        }else{//new end if already favorited
            print("//////UNFAVORITING/////")
            TwitterClient.sharedInstance.unlike(Int(tweetID!)!, params: nil, completion: { (error) -> () in
                print("////In process of unfavoriting////")
                if self.tweet.heartCount > 1{
                    self.favoriteCount.text = String(self.tweet.heartCount - 1)
                }else{
                    self.favoriteCount.hidden = true
                    self.favoriteCount.text = String(self.tweet.heartCount - 1)
                }
                self.tweet.didFavorite = !self.tweet.didFavorite

                self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-off.jpg"), forState: UIControlState.Normal)
            
            })
        }//end else
    }
    
    
    
}
