//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Aditya Dhingra on 3/6/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import AFNetworking

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var tweet: UIButton!
    
    var counter: Int = 0
    
    @IBAction func tweetPressed(_ sender: Any) {
        TwitterClient.sharedInstance?.tweetNew(status: textInput.text!, failure: { (error: Error) in
            print(error.localizedDescription)
            })
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.delegate = self
        
        // Do any additional setup after loading the view.
        name.text = User.currentUser?.name
        username.text = User.currentUser?.screenName
        userImage.setImageWith((User.currentUser?.profileImageURL)!)
        
        charCount.text = "\(140 - counter) remaining"
        
        tweet.layer.cornerRadius = 10
        tweet.clipsToBounds = true
        tweet.layer.borderColor = UIColor.black.cgColor
        tweet.layer.borderWidth = 1
        
        userImage.layer.cornerRadius = 5
        userImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        counter = textInput.text.characters.count
        if(counter > 140) {
            let alert = UIAlertController(title: "Alert", message: "Word limit exceeded!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        counter = textInput.text.characters.count
        charCount.text = "\(140 - counter) remaining"
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
