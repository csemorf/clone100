//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by 💎 on 12/02/2023.
//

import UIKit


class ProfileHeaderViewModel {
    var user:User
    
    init(user:User){
        self.user = user
    }
    
    var followings:NSAttributedString? {
        return attributedText(withValue: 2, text: "followings")
        
    }
    var followers:NSAttributedString? {
        return attributedText(withValue: 0, text: "followers")
    }
    
    var actionButtonTitle:String {
        return user.isCurrentUser ? "Edit Profile" : "Following"
    }
    
  
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [.font : UIFont.boldSystemFont (ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)",
                                                  attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.lightGray]))
        return attributedTitle
                                                       
    }
}
