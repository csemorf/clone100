//
//  UserService.swift
//  TwitterClone
//
//  Created by 💎 on 10/02/2023.
//

import Firebase
import Foundation

struct UserService {
    static let shared = UserService()
    
    func fetch1User(completions: @escaping (User?)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
       
        REF_user.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let userDictionary = snapshot.value as? [String:AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: userDictionary)
            print(user)
            
            completions(user)
            
            
        }
    }
}
