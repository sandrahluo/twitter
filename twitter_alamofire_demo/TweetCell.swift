//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

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
    
    @IBOutlet weak var numReplysLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavsLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            numFavsLabel.text = String(tweet.favoriteCount)
            numRetweetsLabel.text = String(tweet.retweetCount)
            dateLabel.text = tweet.createdAtString
            
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName!
            profileImage.af_setImage(withURL: tweet.user.profileImageURL!)
            
            if (tweet.retweeted == true) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            } else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
            
            if (tweet.favorited == true) {
                faveButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            } else {
                faveButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        // Update local tweet model
        if tweet.favorited == false {
            tweet.favorited = true
            faveButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            tweet.favoriteCount += 1
        
            // Update the cell UI/color
            refreshData()
            
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
            faveButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            tweet.favoriteCount -= 1
            refreshData()
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
        if tweet.retweeted == false {
            tweet.retweeted = true
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            tweet.retweetCount += 1
            
            // Update the cell UI/color
            refreshData()
            
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
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            tweet.retweetCount -= 1
            refreshData()
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
    
    func refreshData() {
            numRetweetsLabel.text = "\(tweet.retweetCount)"
            numFavsLabel.text = "\(tweet.favoriteCount)"
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
