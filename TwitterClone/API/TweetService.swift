//
//  TweetService.swift
//  TwitterClone
//
//  Created by 💎 on 11/02/2023.
//

import Foundation
import Firebase

struct Tweet {
    let tweetId:String
    let uid:String
    let retweets,likes:Int
    let caption:String
    var date:Date!
    let user:User
//tweetId: String , uid: String, retweets: Int, likes: Int, date: Int
    
    init(tweetId:String, dict: [String: Any],user:User) {
        self.tweetId = tweetId
        self.user = user
        self.uid = dict["uid"] as? String ?? ""
        self.retweets = dict["retweets"] as? Int ?? 0
        self.likes = dict["likes"] as? Int ?? 0
        self.caption = dict["caption"] as? String ?? ""
        if let timestamp =  dict["timestamp"] as? Double {
            self.date = Date(timeIntervalSince1970: timestamp)
        }
    }
}

class TweetService {
    static let shared = TweetService()
    
    func uploadTweet(tweet:String,withCompletionBlock:@escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let retweets = 0
        let likes = 0
        
        
        let values = ["caption":tweet,"uid":uid,"timestamp":timestamp,"likes":likes,"retweets":retweets] as [String:Any]
        
        
        
        REF_tweet.childByAutoId().updateChildValues(values, withCompletionBlock: withCompletionBlock)
    }
    func fetchTweets( completions: @escaping ([Tweet]) -> Void){
        var tweets = [Tweet]()
        
        REF_tweet.observe(.childAdded) { snapshot  in
            guard let dict = snapshot.value as? [String:Any],let uid = dict["uid"] as? String else {return}
            let key = snapshot.key
            
            
            UserService.shared.fetch1User(uid: uid) { user in
                guard let user = user else {return}
                let t = Tweet(tweetId: key, dict: dict, user: user)
                tweets.append(t)
                completions(tweets)
            }
        }
    }
}

