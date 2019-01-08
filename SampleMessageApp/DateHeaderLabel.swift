//
//  DateHeaderLabel.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 08/12/18.
//  Copyright © 2018 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

class DateHeaderLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.black
        textColor = UIColor.white
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false //enable autolayout
        font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        
        return CGSize(width: originalContentSize.width + 16, height: height)
    }
}
