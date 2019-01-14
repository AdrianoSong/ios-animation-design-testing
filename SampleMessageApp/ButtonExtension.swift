//
//  ButtonExtension.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 14/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulse(completion: @escaping () -> Void) {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            completion()
        }
    }
}
