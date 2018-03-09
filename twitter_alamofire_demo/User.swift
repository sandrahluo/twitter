//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String?
    var profileImageURL: URL?
    // static property that stores current user after successful login
    static var current: User?
    var dictionary:[String:Any]?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as? String
        let URLString = dictionary["profile_image_url_https"] as? String
        if let URLString = URLString {
            profileImageURL = URL(string: URLString)
        }
    }
}
