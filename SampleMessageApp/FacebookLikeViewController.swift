//
//  FacebookLikeViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 3/4/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

/// follow tutorial: https://www.youtube.com/watch?v=wbmTy32s7GQ&list=PL0dzCUj1L5JFz8NarGPXtvEvaAqUOwaFU
class FacebookLikeViewController: UIViewController {

    fileprivate let bgImageView: UIImageView = {
       
        let view = UIImageView()
        let image = UIImage(named: "facebook")
        
        view.image = image
        view.contentMode = .scaleAspectFill
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    fileprivate let emojisContainer: UIView = {
       
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupBackgroundImageConstraints()
        
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action:
            #selector(handleLongPress(gestue:))))
    }
    
    @objc
    fileprivate func handleLongPress(gestue: UILongPressGestureRecognizer) {
        
        if gestue.state == .began {
            view.addSubview(emojisContainer)
            
            let pressedLocation = gestue.location(in: view)
            let centeredX = (view.frame.width - emojisContainer.frame.width) / 2
            self.emojisContainer.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
            
            emojisContainer.alpha = 0
            
            appearsAnimation(centeredX, pressedLocation)
            
        } else if gestue.state == .ended {
            emojisContainer.removeFromSuperview()
        }
    }
    
    fileprivate func appearsAnimation(_ centeredX: CGFloat, _ pressedLocation: CGPoint) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.emojisContainer.alpha = 1
            
            self.emojisContainer.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.emojisContainer.frame.height)
            
        }, completion: nil)
    }
    
    fileprivate func setupBackgroundImageConstraints() {
        view.addSubview(bgImageView)
        bgImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bgImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
