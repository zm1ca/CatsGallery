//
//  UIHelper.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit

enum UIHelper {
    
    static func createTwoColumnNoPaddingFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let itemWidth                      = (view.bounds.width - 2) / 2
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.sectionInset            = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize                = CGSize(width: itemWidth, height: itemWidth * 1.3)
        flowLayout.minimumLineSpacing      = 2
        flowLayout.minimumInteritemSpacing = 0
        
        return flowLayout
    }
    
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let padding: CGFloat = 20
        let itemWidth = view.bounds.width - 2 * padding
           
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.sectionInset            = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.itemSize                = CGSize(width: itemWidth, height: itemWidth * 1.5)
        flowLayout.minimumLineSpacing      = padding * 2
        flowLayout.scrollDirection = .horizontal

        return flowLayout
    }
}
