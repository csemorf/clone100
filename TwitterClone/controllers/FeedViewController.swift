//
//  FeedViewController.swift
//  TwitterClone
//
//  Created by admin on 08/02/2023.
//

import UIKit

class FeedViewController:UIViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI(){
        view?.backgroundColor = .white
        let imv = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imv.contentMode = .scaleAspectFit
        navigationItem.titleView = imv
    }
}
