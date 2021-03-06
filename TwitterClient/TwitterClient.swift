//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Douglas on 2/8/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "Tnkadfje7scDK8fadid0kNmRd"
let twitterConsumerSecret = "zMeHFJEXElYf5BX8L5FlavUavsgzsX5A8rd3tXFiHXxjBGWZRc"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

let rchange = "true"
let fchange = "true"


class TwitterClient: BDBOAuth1SessionManager{
    
    var loginCompletion: ((user: User?, error: NSError?) ->())?
    
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error:NSError?) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("home timeline: \(response)")
            print("RESPONSES")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            for tweet in tweets{
                print("text: \(tweet.text) , created: \(tweet.createdAt)")
            }
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
        
    }
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) ->()){
        loginCompletion = completion
    
    
        // Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { ( requestToken: BDBOAuth1Credential!) -> Void in
            print("got request token")
            var authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error:NSError!) -> Void in
                print("failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!)-> Void in
            print("Got the acess token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET(
                "1.1/account/verify_credentials.json",
                parameters: nil,
                success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                    print("user: \(response!)")
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    print("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                },
                failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)

            })
            
 
            
            
            }) {(error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error:error)
        }
    }
    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Retweeted tweet with id: \(id)")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: rchange)
            NSUserDefaults.standardUserDefaults().synchronize()
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't retweet")
                print(error)
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: rchange)
                NSUserDefaults.standardUserDefaults().synchronize()

                completion(error: error)
        })//end POST
        
        print("^^^^^^^^^RETWEET CALLED FROM TWITTER CLIENT^^^^^")
    }
    
    func favorited(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Liked tweet with id: \(id)")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: fchange)
            NSUserDefaults.standardUserDefaults().synchronize()
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't like tweet")
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: fchange)
                NSUserDefaults.standardUserDefaults().synchronize()
                completion(error: error)
            }) //end POST
        print("vvvvvvvvvvvvvFAVORITED CALLED FROM TWITTER CLIENT")
    }
    
    func unretweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/unretweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Unretweeted tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't unretweet")
                completion(error: error)
            }
        )
    }
    
    func unlike(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("Unliked tweet with id: \(id)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't unlike tweet")
                completion(error: error)
            }
        )
    }

    
}
