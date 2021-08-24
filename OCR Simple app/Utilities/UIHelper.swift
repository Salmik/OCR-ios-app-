//
//  UIHelper.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

class UIHelper {
    static func createTwoColumFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                        = view.bounds.width
        let padding: CGFloat             = 11
        let minimumItemSpacing: CGFloat  = 10
        let aviableWidth                 = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                    = aviableWidth/2
        
        let flowLayout                   = UICollectionViewFlowLayout()
        flowLayout.sectionInset          = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize              = CGSize(width: itemWidth, height: itemWidth + 35)
        
        return flowLayout
    }
}
