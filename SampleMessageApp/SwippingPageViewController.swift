//
//  AutoLayout2ViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 11/12/18.
//  Copyright © 2018 Adriano Song. All rights reserved.
//

import UIKit

class SwippingPageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, PageCellDelegate {

    let pages = [Page(imageName: "beach", imageTitle: "This is the beach!"),
                 Page(imageName: "camp", imageTitle: "This is the camp!"),
                 Page(imageName: "temple", imageTitle: "This is the temple!")]
    
    let pageControl = UIPageControl()
    
    deinit {
        print("AutoLayout2ViewController free memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Swipping Page"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.white
        
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        
        configBottomControls()
    }
    
    //For landscape orientation to fit screen content
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }, completion: nil)
    }
    
    //For swipe scroll and manage de pagecontrol
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let currentPage = targetContentOffset.pointee.x
        pageControl.currentPage = Int(currentPage / view.frame.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        cell.delegate = self
        
        if indexPath.item == pages.count - 1 {
            cell.isNextButtonEnable = false
        } else {
            cell.isNextButtonEnable = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func didTapFinishTutorial() {
        
        navigationController?.popViewController(animated: true)
    }
    
    private func configBottomControls() {
        
        let previousButton = UIButton(type: .system)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        previousButton.setTitle("PREVIOUS", for: .normal)
        previousButton.backgroundColor = .white
        previousButton.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        
        let nextButton = UIButton(type: .system)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.isUserInteractionEnabled = false
        
        let bottomConstrolsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomConstrolsStackView.distribution = .fillEqually
        
        view.addSubview(bottomConstrolsStackView)
        
        bottomConstrolsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [bottomConstrolsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                           bottomConstrolsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                           bottomConstrolsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                           bottomConstrolsStackView.heightAnchor.constraint(equalToConstant: 50)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func handleNext() {
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc
    private func handlePrevious() {
        
        let nextIndex = max(pageControl.currentPage - 1, 0)
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
