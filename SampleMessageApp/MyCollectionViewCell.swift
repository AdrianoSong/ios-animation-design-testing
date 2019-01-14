//
//  MyCollectionViewCell.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 14/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

protocol MyCollectionViewDelegate {
    func didTapCollectionViewCell()
}

class MyCollectionViewCell: UICollectionViewCell {
    
    let button = UIButton()
    var delegate: MyCollectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupButton() {
        button.setTitle("Go To Next VC", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(jumpToAnotherVC(_:)), for: .touchUpInside)
        
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [button.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                           button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           button.heightAnchor.constraint(equalToConstant: 50),
                           button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                           button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    fileprivate func jumpToAnotherVC(_ sender: UIButton) {
        
        sender.pulse { [weak self] in
            self?.delegate?.didTapCollectionViewCell()
        }
    }
}
