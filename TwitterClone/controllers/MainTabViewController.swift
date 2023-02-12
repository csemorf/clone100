//
//  MainTabViewController.swift
//  TwitterClone
//
//  Created by admin on 08/02/2023.
//

import UIKit
import Firebase


class MainTabViewController: UITabBarController {
    var user:User? {
        didSet {
            guard let nav = viewControllers?.first as? UINavigationController else {return}
            guard let vc = nav.viewControllers[0] as? FeedViewController else {return}
            vc.user = user
            print("main user has set ")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .twitterBlue
        showLoginUserIfNotLogin()
    }
    
    func configureUI(){
        view.addSubview(floatButton)
        floatButton.layer.cornerRadius = 64/2
        floatButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,right:view.rightAnchor,paddingBottom: 64,paddingRight: 16,width: 64,height: 64)
    }
    
    lazy var floatButton : UIButton = {
        let floatButton = UIButton(type: .system)
        floatButton.setImage(UIImage(named: "new_tweet"), for: .normal)
        floatButton.addTarget(self, action: #selector(MainTabViewController.handleTweet), for: .touchUpInside )
        floatButton.tintColor = .white
        floatButton.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        return floatButton
    }()
    
    func configureViewcontrollers(){
        let feedvc = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let nav1 = templateNavigation(image: UIImage(named: "home_unselected")
                                      , vc: feedvc)
        
        
        let notif = ExploreViewController()
        
        let nav2 =  templateNavigation(image: UIImage(named: "search_unselected")
                                       , vc: notif)
        
        let con = ConversationViewController()
        
        let nav3 =   templateNavigation(image: UIImage(named: "like_unselected")
                                        , vc: con)
        
        let expl = NotificationViewController()
        let nav4 =    templateNavigation(image: UIImage(named: "comment")
                                         , vc: expl)
        
        
        viewControllers = [nav1,nav2,nav3,nav4]
        
    }
    
    func showLoginUserIfNotLogin(){
        if (Auth.auth().currentUser == nil) {
            print("user logout")
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav , animated: true)
            }
        }else {
            configureViewcontrollers()
            configureUI()
            guard let uid = Auth.auth().currentUser?.uid else {return}
            UserService.shared.fetch1User(uid: uid) { user in
                guard let user = user else {return}
                self.user = user
            }
        }
    }
    @objc func handleTweet() {
        guard let user = user else {return}
        let vc = UploadTweetViewController(user: user)
        let tweetvc = UINavigationController(rootViewController: vc)
        tweetvc.modalPresentationStyle = .fullScreen
        present(tweetvc, animated: true)
        
    }
    func logoutUser(){
        do{
            try Auth.auth().signOut()
        } catch  {
            print(error.localizedDescription)
        }
    }
    func templateNavigation(image:UIImage?, vc:UIViewController) -> UINavigationController{
        let nav =    UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}


