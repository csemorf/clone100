//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by admin on 08/02/2023.
//

import UIKit
import SDWebImage

class FeedViewController:UICollectionViewController {
    var user:User?  {
        didSet {
            setLeftProfileImageFromUser()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: "tweetCell")
        configureUI()
        fetchTweets()
    }
    func fetchTweets(){
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    func configureUI(){
        view?.backgroundColor = .white
        let imv = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imv.contentMode = .scaleAspectFit
        imv.setDimensions(width: 42, height: 42)
        navigationItem.titleView = imv
       
    }
    func setLeftProfileImageFromUser(){
        guard let user = user else {return}
        let leftImage = UIImageView()
        leftImage.setDimensions(width: 24, height: 24)
        leftImage.layer.cornerRadius = 24/2
        leftImage.layer.masksToBounds = true
        
        leftImage.sd_setImage(with: user.profileImageUrl)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftImage)
    }
}


extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select cell")
    }
    
}
extension FeedViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension FeedViewController:TweetCellDelegateTapProfileImage {
    func didProfileImageTap() {
        print("tap from collectionview")
        let c = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(c, animated: true)
    }
}
