//
//  Constant.swift
//  TwitterClone
//
//  Created by 💎 on 10/02/2023.
//


import Firebase
import FirebaseStorage


let STORAGE_REF  = Storage.storage().reference()
let STORAGE_REF_profileImage = Storage.storage().reference().child("profile_images")


let DB_ref =  Database.database().reference()
let REF_user =  Database.database().reference().child("users")

let REF_tweet =  Database.database().reference().child("tweets")
let REF_USER_TWEET =  Database.database().reference().child("user-tweets")


