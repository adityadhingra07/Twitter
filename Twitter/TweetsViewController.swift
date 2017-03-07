//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Aditya Dhingra on 2/27/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "displayProfile", sender: self)
    }
    
    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let thisTweet = tweets[indexPath.row]
        cell.thisTweet = thisTweet
        cell.profileImageView.setImageWith((thisTweet.user?.profileImageURL)!)
        cell.usernameLabel.text = thisTweet.user?.name
        cell.displayLabel.text = "@\((thisTweet.user?.screenName)!)"
        cell.tweetTextLabel.text = thisTweet.text
        
        cell.timestampLabel.text = "\(Int((thisTweet.createdAt?.timeIntervalSinceNow.rounded())! * -1 / 60)) min"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "displayTweet", sender: indexPath)
        tweetsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func onLogoutButtonClick(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayTweet"){
            let vc = segue.destination as! TweetDetailViewController
            let indexPath = sender as! IndexPath
            vc.tweet = self.tweets[indexPath.row]
        }
        else if (segue.identifier == "displayProfile") {
            let vc = segue.destination as! ProfileViewController
            vc.user = User.currentUser
        }
    }

}
