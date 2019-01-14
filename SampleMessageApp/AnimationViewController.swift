//
//  AnimationViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 04/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    private let titleVCLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "The end is Here!"
        view.backgroundColor = .white
        
        createInfoLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func createInfoLabel() {
       
        titleVCLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleVCLabel.text = "Please, tap here!"
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfoLabelAnimation)))
        view.addSubview(titleVCLabel)
        
        titleVCLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [titleVCLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                           titleVCLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    fileprivate func handleInfoLabelAnimation() {
        
        //prevent to call a lot of animationsf
        if self.titleVCLabel.alpha > 0 {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                
                self?.titleVCLabel.transform  = CGAffineTransform(translationX: 0, y: -200)
                self?.titleVCLabel.alpha = 0
            
            }) { [weak self] (_) in
                
                self?.createAngrySushiAnimation()
            }
        }
    }
    
    private func createAngrySushiAnimation() {
        let angrySushi = LOTAnimationView(name: "a_very_angry_sushi")
        
        view.addSubview(angrySushi)
        
        angrySushi.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [angrySushi.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                           angrySushi.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           angrySushi.widthAnchor.constraint(equalToConstant: 200),
                           angrySushi.heightAnchor.constraint(equalToConstant: 200)]
        
        NSLayoutConstraint.activate(constraints)
        
        angrySushi.loopAnimation = true
        angrySushi.contentMode = .scaleAspectFit
        angrySushi.play()
        
        createGoodbyeLabel(viewParent: angrySushi)
    }
    
    private func createGoodbyeLabel(viewParent: UIView) {
        
        let goodByeLabel = UILabel()
        goodByeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        goodByeLabel.textAlignment = .center
        goodByeLabel.text = "That's all folks! See you later"
        goodByeLabel.numberOfLines = 0
        
        view.addSubview(goodByeLabel)
        
        goodByeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [goodByeLabel.topAnchor.constraint(equalTo: viewParent.bottomAnchor, constant: 16),
                           goodByeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                           goodByeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
