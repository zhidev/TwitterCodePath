//
//  DetailedViewController.swift
//  TwitterClient
//
//  Created by Douglas on 2/26/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var handleLabel: UILabel!
    
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var tweetView: UITextView!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var rcount: UILabel!
    @IBOutlet var fcount: UILabel!
    	
    var tweetID: String?
    var newtweet: Tweet?/*{
        didSet{
            print("POTATO")
            print("retweet: \(newtweet!.didRetweet)")
            print("text: \(newtweet!.text!)")
            print("name: \(newtweet!.user?.screenName)")
            
            //self.handleLabel.text = newtweet!.user?.screenName!
            
            if(newtweet!.didRetweet){
                print("RETWEET COLORED")                //retweetButton.setBackgroundImage(UIImage(named: "retweet-action-on-green.jpg"), forState: UIControlState.Normal)
            }else{
                //self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action_default.jpg"), forState: UIControlState.Normal)
                print("FISH")
            }//if else tweet did retweet
        }
    }*/ //ALRIGHT WRITING THIS INTO README MARK515 wasted a good hour on this.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = newtweet!.user?.name
        let usernameText = "@" + (newtweet!.user?.screenName)!
        self.handleLabel.text = usernameText
        self.avatarImage.setImageWithURL( (NSURL(string: (newtweet!.user?.profileImageURL!)!))! )
        self.tweetView.text = newtweet!.text
        self.timeLabel.text = calculateTimestamp(newtweet!.createdAt!.timeIntervalSinceNow)
        if(newtweet!.didRetweet){
            retweetButton.setBackgroundImage(UIImage(named: "retweet-action-on-green.jpg"), forState: UIControlState.Normal)
        }else{
            self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action_default.jpg"), forState: UIControlState.Normal)
        }//if else tweet did retweet
        if(newtweet!.didFavorite){
            print("FAVORITE COLORED")
            self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-on-red.jpg"), forState: UIControlState.Normal)
        }else{
            self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-off.jpg"), forState: UIControlState.Normal)
        }//end favorite
        self.rcount.text = String(newtweet!.retweetCount)
        self.fcount.text = String(newtweet!.heartCount)
        
        //self.rcount.text! == "0" ? (rcount.hidden = true) : (rcount.hidden = false)
        //self.fcount.text! == "0" ? (fcount.hidden = true) : (fcount.hidden = false)
        
        rcount.text! = rcount.text!
        fcount.text! = fcount.text!

        tweetID = newtweet!.id
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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

    @IBAction func replyHit(sender: AnyObject) {
    }
    
    @IBAction func favoriteHit(sender: AnyObject) {
        if(!self.newtweet!.didFavorite){
            TwitterClient.sharedInstance.favorited(Int(tweetID!)!, params: nil, completion: {(error) -> () in
                if self.newtweet!.heartCount > 0 {
                    self.fcount.text = String(self.newtweet!.heartCount + 1)
                }else{
                    self.fcount.hidden = false
                    self.fcount.text = String(self.newtweet!.heartCount + 1)
                }
                self.newtweet!.didFavorite = !self.newtweet!.didFavorite
                self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-on-red.jpg"), forState: UIControlState.Normal)
            })
        }else{//new end if already favorited
            print("//////UNFAVORITING/////")
            TwitterClient.sharedInstance.unlike(Int(tweetID!)!, params: nil, completion: { (error) -> () in
                print("////In process of unfavoriting////")
                if self.newtweet!.heartCount > 1{
                    self.fcount.text = String(self.newtweet!.heartCount - 1)
                }else{
                    self.fcount.hidden = true
                    self.fcount.text = String(self.newtweet!.heartCount - 1)
                }
                self.newtweet!.didFavorite = !self.newtweet!.didFavorite
                
                self.favoriteButton.setBackgroundImage(UIImage(named: "like-action-off.jpg"), forState: UIControlState.Normal)
                
            })
        }//end else
    }
    
    @IBAction func retweetHit(sender: AnyObject) {
        if(!self.newtweet!.didRetweet){ //if it didnt retweet yet
            TwitterClient.sharedInstance.retweet(Int(tweetID!)!, params: nil, completion: { (error)->() in
                
                
                let data = NSUserDefaults.standardUserDefaults().boolForKey(rchange)
                if data{
                    if self.rcount.text! > "0"{
                        self.rcount.text = String(self.newtweet!.retweetCount + 1)
                    }else{
                        self.rcount.hidden = false
                        self.rcount.text = String(self.newtweet!.retweetCount + 1)
                    }
                    self.newtweet!.didRetweet = !self.newtweet!.didRetweet
                    self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action-on-green.jpg"), forState: UIControlState.Normal)
                }//end if data
                
            })//end retweet
        }else{//end if loop for didRetweet
            //deleting a retweet
            TwitterClient.sharedInstance.unretweet(Int(tweetID!)!, params: nil, completion: { (error)->() in
                if self.newtweet!.retweetCount > 1{
                    self.rcount.text = String(self.newtweet!.retweetCount - 1)
                }else{//end if retweet count >1
                    //else only 1 retweet (users) so hide everything
                    self.rcount.hidden = true
                    self.rcount.text = String(self.newtweet!.retweetCount - 1)
                    
                }
            })
            self.newtweet!.didRetweet = !self.newtweet!.didRetweet
            
            self.retweetButton.setBackgroundImage(UIImage(named: "retweet-action_default.jpg"), forState: UIControlState.Normal)
        }
    }
    
    
    
    
    
}
