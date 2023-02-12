//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import Foundation
import UIKit

class TweetViewModel {
    let tweet:Tweet
    let user:User
    
    var profileImageUrl:URL? {
        return user.profileImageUrl
    }
    
    var userInfoText:NSAttributedString {
        let att = NSMutableAttributedString(string: tweet.user.fullname,
                                     attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,.font:UIFont.boldSystemFont(ofSize: 14)])
        
        att.append(NSAttributedString(string: " @\(tweet.user.username)",
                                      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                   NSAttributedString.Key.foregroundColor:UIColor.lightGray]))
        att.append(NSAttributedString(string: " • \(timestamp)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        return att
        
    }
    var timestamp:String {
        let datef = DateComponentsFormatter()
        datef.allowedUnits = [.day, .minute,.hour,.second, .weekOfMonth]
        datef.unitsStyle = .abbreviated
        datef.maximumUnitCount = 1
        return datef.string(from: tweet.date, to: Date()) ?? "2m"
    }
    init(tweet:Tweet){
        self.tweet=tweet
        self.user=tweet.user
    }
}

