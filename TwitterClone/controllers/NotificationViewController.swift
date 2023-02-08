//
//  NotificationViewController.swift
//  TwitterClone
//
//  Created by admin on 08/02/2023.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Message"
    }

}
