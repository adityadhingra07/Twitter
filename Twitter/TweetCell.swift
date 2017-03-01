//
//  TweetCell.swift
//  Twitter
//
//  Created by Aditya Dhingra on 2/27/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var thisTweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if (thisTweet?.favorited ?? false) {
            favoriteButton.setImage(UIImage.init(named: "favor-icon-red"), for: .normal)
        }
        if (thisTweet?.retweeted ?? false) {
            retweetButton.setImage(UIImage.init(named: "retweet-icon-green"), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        // Configure the view for the selected state
    }
    
    
    @IBAction func onFavoriteButtonClicked(_ sender: Any) {
        if (thisTweet?.favorited ?? false) {
            thisTweet?.unfavorite()
            favoriteButton.setImage(UIImage.init(named: "favor-icon"), for: .normal)
        } else {
            thisTweet?.favorite()
            favoriteButton.setImage(UIImage.init(named: "favor-icon-red"), for: .normal)
        }
    }
    
    @IBAction func onRetweetButtonClicked(_ sender: Any) {
        if (thisTweet?.retweeted ?? false) {
            thisTweet?.unretweet()
            retweetButton.setImage(UIImage.init(named: "retweet-icon"), for: .normal)
        } else {
            thisTweet?.retweet()
            retweetButton.setImage(UIImage.init(named: "retweet-icon-green"), for: .normal)
        }
    }

    
}

