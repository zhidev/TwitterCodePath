//
//  User.swift
//  TwitterClient
//
//  Created by Douglas on 2/9/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit


var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageURL: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    


    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        
        
    }
    
    func logout(){
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    
    class var currentUser: User?{
        get{
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    do{
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    }//end do
                    catch(let error){
                        print(error)
                        assert(false)
                    }//end catch
                }//end if data != nil
            }//end if _currUser ==nil
            else{
                print("No data, CurrentUser is nil")
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
        
            if _currentUser != nil{
                do{
                    
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }
                catch _{
                    NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                }
                NSUserDefaults.standardUserDefaults().synchronize()

                
            }
        }
    }
    
}
