//
//  ProfileFilterOptions.swift
//  TwitterClone
//
//  Created by 💎 on 12/02/2023.
//

import UIKit

enum ProfileFilterOptions:Int,CaseIterable {
    case tweets,replies,likes
    
    
    var description:String {
        switch self{
        case .replies:
            return "Tweets and Replies"
        case .tweets:
            return "Tweets "
        case .likes:
            return "Likes"
        }
    }
    
}
