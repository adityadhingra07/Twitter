//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Aditya Dhingra on 3/6/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    @IBOutlet weak var numRetweets: UILabel!
    @IBOutlet weak var numFav: UILabel!
    
    @IBAction func onImageTap(_ sender: Any) {
        performSegue(withIdentifier: "displayProfile", sender: self)
    }
    
    var tweet: Tweet?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = tweet?.user

        userImage.setImageWith((user?.profileImageURL)!)
        name.text = user?.name
        username.text = "@" + (user?.screenName)!
        tweetText.text = tweet?.text
        
        numRetweets.text = "\((tweet?.retweetCount)!)"
        numFav.text = "\((tweet?.favoriteCount)!)"
        
        let time = Int((tweet!.createdAt?.timeIntervalSinceNow)!)
        if (-time/3600) == 0 {
            tweetTime.text = "\(-time/60)m"
        } else {
            tweetTime.text = "\(-time/3600)h"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayProfile") {
            let vc = segue.destination as! ProfileViewController
            vc.user = self.user
        }
    }

}
