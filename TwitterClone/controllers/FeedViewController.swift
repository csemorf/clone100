//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by admin on 08/02/2023.
//

import UIKit
import SDWebImage

class FeedViewController:UIViewController {
    var user:User?  {
        didSet {
            setLeftProfileImageFromUser()
        }
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        configureUI()
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
