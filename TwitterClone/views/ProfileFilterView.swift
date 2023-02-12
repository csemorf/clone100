//
//  ProfileFilterView.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import UIKit
protocol ProfileFilterViewDelegate: AnyObject {
    func setOffsetDivideView(v:ProfileFilterView, indexPath:IndexPath)
}
class ProfileFilterView:UIView{
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .twitterBlue
        return cv
    }()
    weak var delegate:ProfileFilterViewDelegate?
    
    var firstSelect = false
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        addSubview(collectionView)
        collectionView.register(ProfileFilterViewCell.self, forCellWithReuseIdentifier: "profileFilterViewCell")
        collectionView.addConstraintsToFillView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProfileFilterView:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 3 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileFilterViewCell", for: indexPath) as! ProfileFilterViewCell
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.setOffsetDivideView(v:self,indexPath:indexPath)
    }
}

extension ProfileFilterView:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/3, height: frame.height)
    }
}
