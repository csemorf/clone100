//
//  UploadTweetViewController.swift
//  TwitterClone
//
//  Created by 💎 on 11/02/2023.
//

import UIKit

class UploadTweetViewController: UIViewController {
    private let user:User
    
    
    init(user:User) {
        self.user = user
        super.init(nibName: nil, bundle: nil   )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBackground()
        
        
    }
    func configureNavBackground(){
        let app = UINavigationBarAppearance()
        app.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = app
        navigationController?.navigationBar.scrollEdgeAppearance = app
        
        //
        //        navigationController?.navigationBar.barTintColor = .white
        //        navigationController?.navigationBar.isTranslucent = false
    }
    
    lazy var cancelButton:UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.addTarget(self, action:#selector(UploadTweetViewController.handlecancel), for: .touchUpInside)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.twitterBlue, for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cancelButton
    }()
    
    lazy var tweetButton:UIButton = {
        let tweetButton = UIButton(type: .system)
        tweetButton.setTitle("Tweet", for: .normal)
        tweetButton.backgroundColor = .twitterBlue
        tweetButton.setTitleColor(.white, for: .normal)
        tweetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        tweetButton.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        tweetButton.layer.cornerRadius = 32/2
        tweetButton.addTarget(self, action:#selector(UploadTweetViewController.handletweet), for: .touchUpInside)
        return tweetButton
    }()
    
    let profileImage:UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.setDimensions(width: 48, height: 48)
        imv.layer.cornerRadius = 47/2
        imv.backgroundColor = .twitterBlue
        return imv
    }()
    let captionTextView = CaptionTextView()
    
    func configureUI(){
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:tweetButton)
        
        let stack = UIStackView(arrangedSubviews: [profileImage,captionTextView])
        stack.spacing = 12
        stack.axis = .horizontal
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,right: view.rightAnchor
                     ,paddingTop: 16
                     ,paddingLeft: 16,paddingRight: 16)
        
        profileImage.sd_setImage(with: user.profileImageUrl)
    }
    
    @objc func handlecancel(){
        dismiss(animated: true)
    }
    
    @objc func handletweet(){
        TweetService.shared.uploadTweet(tweet: captionTextView.text) { err, ref in
            if let err = err {
                print("err \(err.localizedDescription)")
                return
            }
            
            print("ok")
            self.dismiss(animated: true)
        }
    }
}

