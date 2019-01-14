//
//  StretchyHeaderLayout.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 14/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader &&
                attributes.indexPath.section == 0 { //if have a multiple headers get the first one
                
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY > 0 {
                    return
                }
                
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffsetY
                
                //header
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
            
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
