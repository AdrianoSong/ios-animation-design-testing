//
//  PageCell.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 03/01/19.
//  Copyright © 2019 Adriano Song. All rights reserved.
//

import UIKit

protocol PageCellDelegate {
    func didTapFinishTutorial()
}

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            
            beachImageView?.image = UIImage(named: page.imageName)
            myTitle?.text = page.imageTitle
        }
    }
    
    var delegate: PageCellDelegate?
    
    private var beachImageView: UIImageView?
    private var myTitle: UILabel?
    private var myDescription: UILabel?
    private var topImageContainerView: UIView?
    private var nextVCButton: UIButton?
    
    open var isNextButtonEnable: Bool = true {
        didSet {
            nextVCButton?.isHidden = isNextButtonEnable
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let beachImage = UIImage(named: "beach")
        beachImageView = UIImageView(image: beachImage)
        myTitle = UILabel()
        myDescription = UILabel()
        nextVCButton = UIButton(type: .system)
        
        configBeachImage()
        configTitle()
        configDescription(viewParent: myTitle)
        configNextVCButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     The strategy is: create an UIView for getting the top half of the screen
     to place my imageview for landscape and portrait mode
     change background color to see the UIView
     */
    private func createViewBackgroundForBeachImage(beachImageView: UIView) -> UIView {
        
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .white
        addSubview(topImageContainerView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(beachImageView)
        
        return topImageContainerView
    }
    
    private func configBeachImage() {
        
        guard let beachImageView = self.beachImageView else {
            return
        }
        
        beachImageView.translatesAutoresizingMaskIntoConstraints = false
        beachImageView.contentMode = .scaleAspectFit
        
        topImageContainerView = createViewBackgroundForBeachImage(beachImageView: beachImageView)
        
        guard let topImageContainerView = self.topImageContainerView else {
            return
        }
        
        let constraints = [beachImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
                           beachImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
                           beachImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configTitle(){
        
        guard let myTitle = self.myTitle else {
            return
        }
        
        myTitle.text = "This is the beach title!"
        myTitle.numberOfLines = 0
        myTitle.textAlignment = .center
        myTitle.font = UIFont.boldSystemFont(ofSize: 24)
        
        addSubview(myTitle)
        
        myTitle.translatesAutoresizingMaskIntoConstraints = false
        
        guard let topImageContainerView = self.topImageContainerView else {
            return
        }
        
        let constraints = [myTitle.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 50),
                           myTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           myTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configDescription(viewParent: UIView?) {
        
        guard let parentView = viewParent,
            let myDescription = self.myDescription else {
                return
        }
        
        myDescription.numberOfLines = 0
        myDescription.textAlignment = .center
        
        let attributedText = NSMutableAttributedString(string: "Here is my beach description. Great beach!!!\n", attributes: [.font: UIFont.systemFont(ofSize: 18)])
        attributedText.append(NSMutableAttributedString(string: "Adding more text to my beach, It's a great beach, with a lot of water and hug amount of sand!!!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        
        myDescription.attributedText = attributedText
        
        addSubview(myDescription)
        
        myDescription.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [myDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
                           myDescription.topAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 8),
                           myDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           myDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configNextVCButton() {
        
        guard let nextVCButton = self.nextVCButton else {
            return
            
        }
        
        nextVCButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextVCButton.setTitle("finish slide tutorial", for: .normal)
        nextVCButton.addTarget(self, action: #selector(goToNextVC), for: .touchUpInside)
        
        let view = UIView()
        view.backgroundColor = .purple
        
        addSubview(nextVCButton)
        nextVCButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [nextVCButton.topAnchor.constraint(equalTo: topAnchor, constant: 48),
                           nextVCButton.heightAnchor.constraint(equalToConstant: 50),
                           nextVCButton.widthAnchor.constraint(equalToConstant: 150),
                           nextVCButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func goToNextVC() {
        delegate?.didTapFinishTutorial()
    }
}
