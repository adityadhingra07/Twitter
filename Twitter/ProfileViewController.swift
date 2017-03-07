//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Aditya Dhingra on 3/6/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var tweets: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    
    var user: User?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.setImageWith((user?.profileImageURL)!)
        name.text = user?.name
        username.text = "@" + (user?.screenName)!
        tweets.text = "\((user?.tweetsCount)!)"
        following.text = "\((user?.followingCount)!)"
        followers.text = "\((user?.followersCount)!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
