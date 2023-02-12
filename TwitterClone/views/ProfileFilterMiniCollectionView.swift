//
//  ProfileFilterView.swift
//  TwitterClone
//
//  Created by admin on 12/02/2023.
//

import UIKit
protocol ProfileFilterViewDelegate: AnyObject {
    func setOffsetDivideView(v:ProfileFilterMiniCollectionView, indexPath:IndexPath)
}
class ProfileFilterMiniCollectionView:UIView{
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .twitterBlue
        return cv
    }()
    weak var delegate:ProfileFilterViewDelegate?
    
//    let options = [ProfileFilterOptions.likes,ProfileFilterOptions.replies,ProfileFilterOptions.tweets]
    var firstSelect = false
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        addSubview(collectionView)
        collectionView.register(ProfileFilterOptionsViewCell.self, forCellWithReuseIdentifier: "profileFilterViewCell")
        collectionView.addConstraintsToFillView(self)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0)
                                  , animated: true, scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension ProfileFilterMiniCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ProfileFilterOptions.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileFilterViewCell", for: indexPath) as! ProfileFilterOptionsViewCell
        
        cell.options = ProfileFilterOptions(rawValue: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.setOffsetDivideView(v:self,indexPath:indexPath)
    }
}

extension ProfileFilterMiniCollectionView:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if   indexPath.row == 1 {
            return CGSize(width: frame.width/3+10, height: frame.height)
            
        }
        return CGSize(width: frame.width/3-5, height: frame.height)
    }
}



