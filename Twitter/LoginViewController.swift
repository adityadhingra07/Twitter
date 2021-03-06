//
//  LoginViewController.swift
//  Twitter
//
//  Created by Aditya Dhingra on 2/27/17.
//  Copyright © 2017 Aditya Dhingra. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButtun: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtun.layer.cornerRadius = 10
        loginButtun.layer.borderWidth = 2
        loginButtun.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }

}
