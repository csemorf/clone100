//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by 💎 on 09/02/2023.
//
//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

import Firebase

import UIKit
extension LoginViewController {

}
class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.barStyle = .black
    }
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        view.addSubview(twitterButton)
        twitterButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        twitterButton.setDimensions(width: 120, height: 120)
        let stack = UIStackView(arrangedSubviews: [emailViews,pwViews,loginButton])
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        let donthavebtn = Utilities.attributeButton(first: "Dont have account", second: " Signup")
        view.addSubview(donthavebtn)
        
        stack.anchor(top: twitterButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        donthavebtn.addTarget(self, action: #selector(LoginViewController.handleSignup), for: .touchUpInside)
        donthavebtn.anchor(left: view.leftAnchor,bottom:view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 40,paddingBottom: 16,paddingRight: 40)
    }
   
    let twitterButton:UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "TwitterLogo")
        imgV.contentMode = .scaleAspectFit
        imgV.clipsToBounds = true
        return imgV
    }()
    
    lazy var loginButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(LoginViewController.handleLogin), for: .touchUpInside)
        return btn
    }()
    lazy var emailViews:UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        let view =  Utilities.inputContainerView(im: image,textField:emailTf)
        return view
    } ()
    lazy var pwViews:UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let view = Utilities.inputContainerView(im: image, textField:pwTf)
            
        return view
    } ()
    let emailTf :UITextField = {
        let tf = Utilities.textField(withPlaceholer: "Email")
        return tf
    }()
    let pwTf :UITextField = {
        let tf = Utilities.textField(withPlaceholer: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    @objc func handleLogin(){
        guard let email=emailTf.text,let pw = pwTf.text else{return}
        AuthService.shared.loginUser(email: email, pw: pw) { result, err in
            if err != nil {
                print("error")
                return
            }
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }

            guard let vc = window.rootViewController as? MainTabViewController else {return}
                    vc.showLoginUserIfNotLogin()
            self.dismiss(animated: true)
            
            
            
        }
    }
    
    @objc func handleSignup(){
        let reController = RegisterViewController()
        navigationController?.pushViewController(reController, animated: true)
    }
    
    
}
