//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by 💎 on 10/02/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    let imagePicker = UIImagePickerController()
    
    var profileImage :UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    func configureUI(){
        imagePicker.delegate = self
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        view.addSubview(avatarButton)
        avatarButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 20)
        
        let stack = UIStackView(arrangedSubviews: [emailViews,pwViews,fnViews,unViews,registerButton])
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        let donthavebtn = Utilities.attributeButton(first: "Already have account", second: " Login")
        view.addSubview(donthavebtn)
        
        stack.anchor(top: avatarButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop:32,paddingLeft: 32,paddingRight: 32)
        donthavebtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        donthavebtn.anchor(left: view.leftAnchor,bottom:view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 40,paddingRight: 40)
    }
    
    lazy var avatarButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.setDimensions(width: 128, height: 128)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(RegisterViewController.handleAddProfilePhoto), for: .touchUpInside)
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var registerButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(RegisterViewController.handleSignup), for: .touchUpInside)
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
    lazy var fnViews:UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let view = Utilities.inputContainerView(im: image, textField:fntf)
        
        return view
    } ()
    lazy var unViews:UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        let view = Utilities.inputContainerView(im: image, textField:untf)
        
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
    let untf:UITextField = {
        let tf = Utilities.textField(withPlaceholer: "Username")
        return tf
    }()
    let fntf :UITextField = {
        let tf = Utilities.textField(withPlaceholer: "Fullname")
        return tf
    }()
    
    @objc func login(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignup(){
        
        guard let profileImage = profileImage else {
            print("fill image"); return
        }
        
        guard let username = untf.text?.lowercased(),
              let fullname = fntf.text,
              let email = emailTf.text,
              let pw = pwTf.text else {return}


        let user = UserCredentials(email: email, password: pw, username: username, fullname: fullname, profileImage: profileImage)
        
        AuthService.shared.registerUser(userCredential:user) { err, ref in
            print("success register")
            print("handle successfully")
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }

            
            self.navigationController?.popViewController(animated: true)
            guard let vc = window.rootViewController as? MainTabViewController else {return}
                    vc.showLoginUserIfNotLogin()
        }
    }
    
    @objc func handleAddProfilePhoto(){
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
}
extension RegisterViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage = editImage
            
            avatarButton.setImage(editImage.withRenderingMode(.alwaysOriginal) , for: .normal)
            avatarButton.layer.cornerRadius = 128/2
            avatarButton.layer.masksToBounds = true
            avatarButton.layer.borderColor = UIColor.white.cgColor
            avatarButton.layer.borderWidth = 3
            avatarButton.imageView?.contentMode = .scaleAspectFill
            avatarButton.imageView?.clipsToBounds =  true
            dismiss(animated: true)
        }
    }
}
