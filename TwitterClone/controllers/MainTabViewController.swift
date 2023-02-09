//
//  MainTabViewController.swift
//  TwitterClone
//
//  Created by admin on 08/02/2023.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureViewcontrollers()
        configureUI()
    }
    
    func configureUI(){
        view.addSubview(floatButton)
        floatButton.layer.cornerRadius = 64/2
        floatButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,right : view.rightAnchor,paddingBottom: 64,paddingRight: 16,width: 64,height: 64)
    }
    let floatButton : UIButton = {
        let floatButton = UIButton(type: .system)
        floatButton.setImage(UIImage(named: "new_tweet"), for: .normal)
        
        floatButton.tintColor = .white
        floatButton.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        return floatButton
    }()
    
    func configureViewcontrollers(){
        let feedvc = FeedViewController()
        
        let nav1 = templateNavigation(image: UIImage(named: "home_unselected")
                                      , vc: feedvc)
        
        
        let notif = ExploreViewController()
        
        let nav2 =  templateNavigation(image: UIImage(named: "search_unselected")
                                       , vc: notif)
        
        let con = ConversationViewController()
        
        let nav3 =   templateNavigation(image: UIImage(named: "like")
                                        , vc: con)
        
        let expl = NotificationViewController()
        let nav4 =    templateNavigation(image: UIImage(named: "comment")
                                         , vc: expl)
        
        
        viewControllers = [nav1,nav2,nav3,nav4]
        
    }
    
    func templateNavigation(image:UIImage?, vc:UIViewController) -> UINavigationController{
        let nav =    UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
