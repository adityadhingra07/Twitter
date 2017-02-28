//
//  Tweet.swift
//  Twitter
//
//  Created by Aditya Dhingra on 2/27/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import Foundation
import UIKit

class Tweet: NSObject {
    
    var text: String?
    var createdAt: Date?
    var retweetCount: Int
    var favoriteCount: Int
    
    init(dictionary: Dictionary<String, Any>) {
        self.text = dictionary["text"] as? String
        self.retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        self.favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        if let timestampString = dictionary["created_at"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            self.createdAt = dateFormatter.date(from: timestampString)
        }
    }
    
    class func tweetsFromArray(dictionaries: [Dictionary<String, Any>]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            tweets.append(Tweet.init(dictionary: dictionary))
        }
        
        return tweets
}

}
