//
//  SplashViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 08/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) { [weak self] in
            self?.presentSpashAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func presentSpashAnimation() {
        
        let countdown = LOTAnimationView(name: "countdown")
        
        view.addSubview(countdown)
        
        countdown.translatesAutoresizingMaskIntoConstraints = false
        
        countdown.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countdown.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        countdown.contentMode = .scaleAspectFit
        countdown.play { [weak self] (_) in
            
            let newVC = ViewController()
            self?.navigationController?.pushViewController(newVC, animated: true)
        }
    }
}
