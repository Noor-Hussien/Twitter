//
//  LoginViewController.swift
//  Twitter
//
//  Created by Noor Ali on 10/11/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // By pressing the button, you are requesting to log into twitter
    @IBAction func onLoginButton(_ sender: Any) {
        // login to twitter if successful else show a message
        let  myUrl = "https://api.twitter.com/oauth/request_token"
        
                    
        TwitterAPICaller.client?.login(url: myUrl, success: {
            // if successful perform seque way, which is transition
            self.performSegue(withIdentifier: "loginToHome", sender: self)

        }, failure: { (Error) in
            print("Couldn't log in!")
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
