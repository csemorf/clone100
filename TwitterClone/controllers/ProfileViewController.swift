//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import UIKit


class ProfileViewController: UICollectionViewController {
    var user:User
    var tweets = [Tweet]()
    {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(user:User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionviewUI()
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: "tweetCell")
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        collectionView.contentInsetAdjustmentBehavior = .never
        TweetService.shared.fetchTweets(for: user) { tweets in
            self.tweets = tweets
        }
    }
    
    func configureCollectionviewUI(){
       navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
       navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = .white
    }
    
}




extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! ProfileHeader
        header.user = user
        header.delegate = self
        return header
    }
}


extension ProfileViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)

    }
    
}
extension ProfileViewController: ProfileHeaderProtocol {
    func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
}
