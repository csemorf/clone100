//
//  Extensions.swift
//  TwitterTutorial
//
//  Created by Stephen Dowless on 1/12/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//
//navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
//navigationController?.navigationBar.barStyle = .black
//        let nav = UINavigationBarAppearance()
//nav.configureWithOpaqueBackground()
//UINavigationBar.appearance().standardAppearance = nav
//UINavigationBar.appearance().scrollEdgeAppearance = nav
//UINavigationBar.appearance().compactAppearance = nav
//collectionView.contentInsetAdjustmentBehavior = .never

import UIKit
class Utilities {
    static func inputContainerView(im:UIImage?,textField:UITextField)->UIView{
        let view = UIView()
        let iv = UIImageView()
        iv.image = im
        view.addSubview(iv)
        view.addSubview(textField)
        view.anchor(height:50)
        iv.anchor(left: view.leftAnchor,bottom: view.bottomAnchor,paddingLeft: 8,paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        textField.anchor(left: iv.rightAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,paddingBottom: 8)
        
        let dView = UIView()
        dView.backgroundColor = .white
        view.addSubview(dView)
        dView.anchor(left:view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,height: 0.75)
        
        return view
    }
    
    static func textField(withPlaceholer:String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = withPlaceholer
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: withPlaceholer, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return tf
    }
    static func attributeButton(first:String, second:String) -> UIButton {
        let btn = UIButton(type: .system)
        let multiAttribute = NSMutableAttributedString(string: first,attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,.font: UIFont.systemFont(ofSize: 16)])
        multiAttribute.append(NSAttributedString(string: second, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.white]))
        btn.setAttributedTitle(multiAttribute, for: .normal)
        return btn
    }
}
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

// MARK: - UIColor

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
}
