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


class TwitterClient: BDBOAuth1SessionManager{
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
