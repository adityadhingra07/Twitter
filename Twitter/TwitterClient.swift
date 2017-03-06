//
//  TwitterClient.swift
//  Twitter
//
//  Created by Aditya Dhingra on 2/27/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let homeTimelineEndpoint: String = "1.1/statuses/home_timeline.json"
    static let verifyCredentialsEndpoint: String = "1.1/account/verify_credentials.json"
    static let newTweet: String = "1.1/statuses/update.json"
    static let baseUrl: String = "https://api.twitter.com"
    static let twitterAuthorizeURL: String = "https://api.twitter.com/oauth/authorize"
    static let twitterConsumerKey: String = "bA2xrdUaKj1WiF2t703pdCqE0"
    static let twitterConsumerSecret: String = "mtx46hr2UmhoR7br1OpQABogtFYEGxYjLLKbeiO9oa7bN4XxMF"
    
    static let sharedInstance = TwitterClient(baseURL: URL.init(string: baseUrl), consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            self.createAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
        }, failure: { (error: Error?) in
            self.loginFailure?(error!)
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL.init(string: "twitterdemoapp://auth_callback"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            let authorizeURL = URL.init(string: TwitterClient.twitterAuthorizeURL + "?oauth_token=\((requestToken?.token)!)")
            UIApplication.shared.open(authorizeURL!, options: [:], completionHandler: nil)
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name.init(User.userLoggedOutNotification), object: nil)
    }
    
    func createAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get(TwitterClient.verifyCredentialsEndpoint, parameters: nil, progress: nil, success: { (URLSessionDataTask, response: Any?) in
            let userDictionary = response as! Dictionary<String, Any>
            let user = User.init(dictionary: userDictionary)
            
            success(user)
        }) { (URLSessionDataTask, error: Error) in
            failure(error)
        }
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get(TwitterClient.homeTimelineEndpoint, parameters: nil, progress: nil, success: { (URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [Dictionary<String, Any>]
            let tweets = Tweet.tweetsFromArray(dictionaries: dictionaries)
            success(tweets)
        }) { (URLSessionDataTask, error: Error) in
            failure(error)
        }
    }
    
    func tweetNew(status: String, failure: @escaping (Error) -> ()) {
        let parameters = NSMutableDictionary()
        parameters["status"] = status
        
        post(TwitterClient.newTweet, parameters: parameters, progress: nil, success: { (URLSessionDataTask, response: Any?) in
            print("Tweeted. (Success)")
        }, failure: { (URLSessionDataTask, error: Error) in
            print("Error Tweeting: ", error)
        })
        
        
    }
}
