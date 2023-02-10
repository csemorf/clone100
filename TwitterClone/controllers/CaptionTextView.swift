//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by 💎 on 11/02/2023.
//

import UIKit

class CaptionTextView: UITextView {

    let placeholderLbl:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .darkGray
        lbl.text = "What's happening"
        return lbl
    }()
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame,textContainer: textContainer)
        backgroundColor = .white
        isScrollEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        font = UIFont.boldSystemFont(ofSize: 16)
        
        addSubview(placeholderLbl)
        placeholderLbl.anchor(top:topAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CaptionTextView.textViewChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func textViewChange(){
        print("change")
        
        placeholderLbl.isHidden = !text.isEmpty
    }
}
