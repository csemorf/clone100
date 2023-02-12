//
//  ProfileFilterViewCell.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import UIKit

class ProfileFilterOptionsViewCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Light Gray"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var options: ProfileFilterOptions! {
        didSet {
            titleLabel.text = options.description
        }
    }
    
    
    
    override var isSelected: Bool
    {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
