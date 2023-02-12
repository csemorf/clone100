//
//  HeaderProfileCell.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import UIKit


class ProfileHeader:UICollectionReusableView {
    
    var user:User? {
        didSet {
            configure()
        }
    }

    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                          paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions (width: 30, height: 30)
        return view
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        let followTap = UITapGestureRecognizer(target: self, action:
                                                #selector (ProfileHeader.handleFollowersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        label.text = "0 Followings"
        return label
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Followers"
        let followTap = UITapGestureRecognizer(target: self, action:
                                                #selector (ProfileHeader.handleFollowingTapped) )
        label.isUserInteractionEnabled  = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    
    @objc func handleFollowersTapped(){
        
    }
    @objc func handleFollowingTapped(){
        
    }
    
        private lazy var backButton: UIButton = {
            let button = UIButton (type: .system)
            button.setImage( #imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector (handleDismissal), for: .touchUpInside)
            return button
        }()
    
    
    
        @objc func handleDismissal(){

        }
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.setDimensions(width: 80, height: 80)
        iv.layer.cornerRadius = 80/2
        iv.layer.borderWidth = 4
        return iv
    }()
        
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton (type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor (.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget (self, action: #selector (handleEditProfileFollow), for: .touchUpInside)
        button.setDimensions(width: 100, height: 36)
        button.layer.cornerRadius = 36 / 2

        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Eddie Brock"
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "@venom"
        return label
    }()
        private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
        }()
    let filterView = ProfileFilterMiniCollectionView()
    
    
    @objc func handleEditProfileFollow(){
        
    }
    
    
    
    func configure() {
        guard let user = user else {return}
        let vm = ProfileHeaderViewModel(user:user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        editProfileFollowButton.setTitle(vm.actionButtonTitle, for: .normal)
        followersLabel.attributedText = vm.followers
        followingLabel.attributedText = vm.followings
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterView.delegate = self
        addSubview(containerView)
        addSubview(profileImageView)
        containerView.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor,height: 108)
        profileImageView.anchor(top:containerView.bottomAnchor,left: containerView.leftAnchor,paddingTop: -24,paddingLeft: 16)
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor,
                                       right: rightAnchor, paddingTop: 12, paddingRight: 12)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel,usernameLabel,bioLabel])
        stack.spacing=4
        stack.axis = .vertical
        
        addSubview(stack)
        stack.anchor(top:profileImageView.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 8,paddingLeft: 12,paddingRight: 12)
        
        addSubview(filterView)
        filterView.anchor(left:leftAnchor,bottom: bottomAnchor, right: rightAnchor,height: 50)
        
        addSubview(divideView)
        divideView.anchor(left:leftAnchor,bottom: bottomAnchor,paddingBottom: 24, width: frame.width/3,height: 2)
        let followStack = UIStackView(arrangedSubviews: [followingLabel,followersLabel])
        addSubview(followStack)
        followStack.spacing = 8
        followStack.axis = .horizontal
        followStack.distribution = .fillProportionally
        
        followStack.anchor(top: stack.bottomAnchor, left:leftAnchor,paddingTop: 8, paddingLeft: 12)
    }
    
    let divideView : UIView = {
        let divideView = UIView()
        divideView.backgroundColor = .twitterBlue
        return divideView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ProfileHeader:ProfileFilterViewDelegate {
    func setOffsetDivideView(v: ProfileFilterMiniCollectionView, indexPath: IndexPath) {
        guard let cell = v.collectionView.cellForItem(at: indexPath) as? ProfileFilterOptionsViewCell else {return}
        let offset = cell.frame.origin.x
        
        UIView.animate(withDuration: 0.2) {
            self.divideView.frame.origin.x = offset
        }
//        self.divideView.anchor(width:self.frame.width/3)
        
    }
}




