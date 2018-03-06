//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import ActiveLabel

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        // Update local tweet model
        if tweet.favorited = false {
            tweet.favorited = true
            tweet.favoriteCount += 1
        
            // Update the cell UI/color
            TweetCell.refreshData()
        
            // Send a POST request to the POST favorites/create endpoint
            APIManager.shared.favorite(tweet) {(tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully favorited the following tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            TweetCell.refreshData()
            APIManager.shared.unfavorite(tweet) {(tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully UNfavorited the following tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        // Update local tweet model
        if tweet.retweeted = false {
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            // Update the cell UI/color
            TweetCell.refreshData()
            
            // Send a POST request to the POST favorites/create endpoint
            APIManager.shared.retweet(tweet) {(tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully favorited the following tweet: \n\(tweet.text)")
                }
            }
        }
        else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            TweetCell.refreshData()
            APIManager.shared.unretweet(tweet) {(tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully UNfavorited the following tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
