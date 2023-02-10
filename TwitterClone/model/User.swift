//
//  User.swift
//  TwitterClone
//
//  Created by 💎 on 10/02/2023.
//

import Foundation

struct User {
    let username,fullname,email,uid:String
    var profileImageUrl:URL?
    
    
    init(uid:String,dictionary:[String:AnyObject] ){
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            let url = URL(string: profileImageUrl)
            self.profileImageUrl = url
        }
        self.email = dictionary["email"] as? String ?? ""
        
    }
}
