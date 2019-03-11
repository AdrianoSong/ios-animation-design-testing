//
//  TinderCardViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 3/9/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

class TinderCardViewController: UIViewController {

    let items = 10
    let cellSpacing: CGFloat = 60
    let cellWidhtAndHeigt = 250
    
    fileprivate let cardCollection: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
//        view.contentInset = UIEdgeInsets(top: 0, left: view.frame.width - 30, bottom: 0, right:)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return view
    }()
    
    fileprivate let xButton: UIButton = {
       
        let view = UIButton()
        
        view.setTitle("X", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupXButtonConstraints()
        setupCardCollectionConstraints()
    }
    
    fileprivate func setupXButtonConstraints() {
        
        xButton.addTarget(self, action: #selector(handleTapXButton), for: .touchUpInside)
        
        view.addSubview(xButton)
        
        xButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        xButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    fileprivate func setupCardCollectionConstraints() {
        
        cardCollection.dataSource = self
        cardCollection.delegate = self
        
        view.addSubview(cardCollection)
        
        cardCollection.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        cardCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cardCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cardCollection.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc
    fileprivate func handleTapXButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension TinderCardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidhtAndHeigt, height: cellWidhtAndHeigt)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        
        return cell
    }
}
