//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import UIKit


class ProfileViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionviewUI()
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: "tweetCell")
        collectionView.register(HeaderProfileCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
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
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tweetCell", for: indexPath) as! TweetCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! HeaderProfileCell
        
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
