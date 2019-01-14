//
//  HeaderCollectionReusableView.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 14/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    let beachHouseImageView = UIImageView(image: UIImage(named: "beachHouse"))
    
    var animator: UIViewPropertyAnimator?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageHeader()
        
        setupBlurEffect()
    }
    
    fileprivate func setupConstraints(view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [view.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                           view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                           view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                           view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func setupImageHeader() {
        
        beachHouseImageView.contentMode = .scaleAspectFill
        
        addSubview(beachHouseImageView)
        
        setupConstraints(view: beachHouseImageView)
    }
    
    fileprivate func setupBlurEffect() {
        
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            
            //here is the end of animation
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            self?.addSubview(visualEffectView)
            
            self?.setupConstraints(view: visualEffectView)
        })        
    }
}
