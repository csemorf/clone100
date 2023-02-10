//
//  AuthService.swift
//  TwitterClone
//
//  Created by 💎 on 10/02/2023.
//

import UIKit
import Firebase


struct UserCredentials {
    let email,password,username,fullname:String
    let profileImage:UIImage
}
class AuthService {
    static let shared = AuthService()
    
    func loginUser(email:String, pw:String, completion: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: pw, completion: completion)
    }
    func registerUser(userCredential:UserCredentials,withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void){
        let email = userCredential.email
        let password = userCredential.password
        let username = userCredential.username
        let fullname = userCredential.fullname
        
        
        guard  let data = userCredential.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let imageUUId = NSUUID().uuidString
        
         let storage_ref_app = STORAGE_REF_profileImage.child(imageUUId)
        
        storage_ref_app.putData(data) { meta, err in
            storage_ref_app.downloadURL { url, err in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("error \(error.localizedDescription)")
                        return
                    }
                    
                    guard  let uid = result?.user.uid else {return}
                    let values = ["email":email,"username":username,"fullname":fullname,"profileImageUrl":profileImageUrl]
                    
                    REF_user.child(uid).updateChildValues(values,withCompletionBlock: withCompletionBlock)

                    
                }

            }
        }
    }
    
    
}
