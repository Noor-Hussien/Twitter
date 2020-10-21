//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Noor Ali on 10/11/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]() // an array of dictionaries
    var numberOfTweet: Int!
    var myRefreshControl = UIRefreshControl() // refresh control
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTweets()
        numberOfTweet = 20
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150



        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        self.loadTweets() // load twitter

        
    }
    
    // This function loads a tweet by calling API caller
    @objc func loadTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = 20
        let myParams = ["count": numberOfTweet] // you can add more params  ["count": 10, "id": "ababcbc]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success:
        { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll() // before we add clean the tweetArray
            for tweet in tweets {
                self.tweetArray.append(tweet) // add it to our array
            }
            
            self.tableView.reloadData() // update the content
            self.myRefreshControl.endRefreshing() // stop refreshing
            
        }, failure: { (Error) in
            print("Couldn't retrieve tweets! oh! no!!")
        })
        
    }
    // this function enables infinte scroll
    func loadMoreTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet += 20
        let myParams = ["count": numberOfTweet] // you can add more params  ["count": 10, "id": "ababcbc]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success:
        { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll() // before we add clean the tweetArray
            for tweet in tweets {
                self.tweetArray.append(tweet) // add it to our array
            }
            
            self.tableView.reloadData() // update the content
//            self.myRefreshControl.endRefreshing() // stop refreshing
            
        }, failure: { (Error) in
            print("Couldn't retrieve tweets! oh! no!!")
        })
        
    }
    // will check if the user scrolled to the bottom
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)  {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
            
        }
        
    }

    
    

    

    @IBAction func onLogout(_ sender: Any) {
        // logout from twitter
        TwitterAPICaller.client?.logout()
        
        self.dismiss(animated: true, completion:nil)
        // if the user logout set varaible userDefaults to false
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note for tweets to display user should start follow people
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as! String // get the name
        cell.tweetContentLabel.text =  tweetArray[indexPath.row]["text"] as! String // refer to one tweet
        
        // set up the image
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
            
        }
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tweetArray.count // size of the tweetArray
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 100
//    }

    

}
