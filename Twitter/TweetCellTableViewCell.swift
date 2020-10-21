//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Noor Ali on 10/12/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var retweeted:Bool = false

    var tweetId:Int =  -1 
    
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite didn't succee: \(error)")
            })
        }
        
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Unfavorite didn't succee: \(error)")
            })
        }
        
    }
    
    
    
    @IBAction func retweetAction(_ sender: Any) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("Error in retweeting: \(error)")
            })
        
    }
    
    // Set the favoriet
    func setFavorite(_ isFavorited:Bool){
        favorited =  isFavorited
        if (favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for:UIControl.State.normal)
            
        }
        else{
            favButton.setImage(UIImage(named:"favor-icon"),
                               for:UIControl.State.normal)
            
        }
    }
    
    
    // Set the favoriet
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for:UIControl.State.normal)
            retweetButton.isEnabled = false // make it not enabled
            
        }
        else{
            retweetButton.setImage(UIImage(named:"retweet-icon"),
                               for:UIControl.State.normal)
            retweetButton.isEnabled = true // make it not enabled
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
