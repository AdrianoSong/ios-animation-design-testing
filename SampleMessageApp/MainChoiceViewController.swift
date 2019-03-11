//
//  MainChoiceViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 3/4/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

class MainChoiceViewController: UITableViewController {

    fileprivate let viewControllers: [UIViewController]? = {
       
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        let swipeVC = SwippingPageViewController(collectionViewLayout: collectionViewFlowLayout)
        swipeVC.title = "tutorial sample VC"
        let newVC = ViewController()
        newVC.title = "animate items tableview"
        
        let stretchyVC = StretchyCollectionViewController(collectionViewLayout: StretchyHeaderLayout())
        stretchyVC.title = "strech header VC"
        
        let animationVC = AnimationViewController()
        animationVC.title = "Animation VC"
        
        let facebookLike = FacebookLikeViewController()
        facebookLike.title = "Facebook like"

        let tinderCardVC = TinderCardViewController()
        tinderCardVC.title = "Card Screen sample"
        
        let views = [newVC, swipeVC, stretchyVC, animationVC, facebookLike, tinderCardVC]
        
        return views
    }()
    
    struct Constant {
        static let cell = "cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Main choice"
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cell)
    }
}

// Mark: - tableview extension

extension MainChoiceViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cell) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = viewControllers?[indexPath.row].title
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if viewControllers?[indexPath.row] is TinderCardViewController {
            
            let tinderVC = TinderCardViewController()
    
            tinderVC.providesPresentationContextTransitionStyle = true
            tinderVC.definesPresentationContext = true
            tinderVC.modalPresentationStyle = .overCurrentContext
            tinderVC.modalTransitionStyle = .crossDissolve
            tinderVC.view.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
            
            present(tinderVC, animated: true, completion: nil)
        } else {
            
            navigationController?.pushViewController(viewControllers?[indexPath.row] ?? UIViewController(),
                                                     animated: true)
        }
    }
}
