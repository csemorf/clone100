//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 💎 on 11/02/2023.
//

import UIKit
protocol TweetCellDelegateTapProfileImage: AnyObject {
    func didProfileImageTap(cell:TweetCell)
}

class TweetCell:UICollectionViewCell {
    weak var delegate:TweetCellDelegateTapProfileImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    var tweet:Tweet? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        guard let tweet = tweet else {return}
        
        let viewModel = TweetViewModel(tweet: tweet)
        self.captionLabel.text = tweet.caption
    
        self.profileImage.sd_setImage(with: viewModel.profileImageUrl)
        
        DispatchQueue.main.async {
            self.infoLabel.attributedText = viewModel.userInfoText
        }
        
//        print(tweet.user.username)
    }
    
    lazy var profileImage:UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.backgroundColor = .twitterBlue
        imv.setDimensions(width: 48, height: 48)
        imv.layer.cornerRadius = 48/2
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TweetCell.profileImageTap)))
        
        return imv
    }()
    
    let infoLabel:UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "Eddie Brock @venom"
        return lbl
    }()
    
   @objc func profileImageTap(){
       delegate?.didProfileImageTap(cell: self)
    }
    let captionLabel:UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Some first Caption Label"
        return lbl
    }()
    
    let divideView:UIView = {
       let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton (type: .system)
        button.setImage (UIImage (named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handlecommentTapped), for: .touchUpInside)
        return button
    }()
     private lazy var retweetButton: UIButton = {
        let button = UIButton (type: .system)
        button.setImage (UIImage (named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleretweetTapped), for: .touchUpInside)
        return button
    }()
     private lazy var likeButton: UIButton = {
        let button = UIButton (type: .system)
        button.setImage (UIImage (named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handlelikeTapped), for: .touchUpInside)
        return button
    }()
     private lazy var shareButton: UIButton = {
        let button = UIButton (type: .system)
        button.setImage (UIImage (named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleshareTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleshareTapped(){
        
    }
    @objc func handlelikeTapped(){
        
    }
    @objc func handleretweetTapped(){
        
    }
    @objc func handlecommentTapped(){
        
    }
    
    func configureUI() {
        addSubview(profileImage)
        profileImage.anchor(top:topAnchor,left: leftAnchor,paddingTop: 12,paddingLeft: 8)
        let stack = UIStackView(arrangedSubviews: [infoLabel,captionLabel])
        stack.spacing = 4
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        
        addSubview(stack)
        stack.anchor(top:profileImage.topAnchor,left: profileImage.rightAnchor,right: rightAnchor,paddingLeft: 12,paddingRight: 12)
        
        let actionstack = UIStackView(arrangedSubviews: [commentButton,likeButton,shareButton,retweetButton])
        addSubview(actionstack)
        actionstack.axis = .horizontal
        actionstack.spacing = 72
//        actionstack.distribution = .fillProportionally
//        actionstack.backgroundColor = .red
        
        actionstack.anchor(bottom: bottomAnchor,paddingBottom: 8)
        actionstack.centerX(inView: self)
                
        
        addSubview(divideView)
        divideView.anchor(left:leftAnchor,bottom: bottomAnchor,right: rightAnchor,height: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

