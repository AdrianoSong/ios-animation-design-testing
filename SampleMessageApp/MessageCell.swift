//
//  MessageCell.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 05/12/18.
//  Copyright © 2018 Adriano Song. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var messageLabel = UILabel()
    var bubbleBackgroundView = UIView()
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    
    var isIncoming: Bool! {
        didSet {
            bubbleBackgroundView.backgroundColor = isIncoming ? UIColor.white : UIColor.darkGray
            messageLabel.textColor = isIncoming ? UIColor.black : UIColor.white
            
            if isIncoming {
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
            } else {
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupBubbblebackgroundView()
        setupMessageLabel()
        constraints(view: &bubbleBackgroundView, labelMessage: &messageLabel)
    }
    
    private func setupMessageLabel(){
        addSubview(messageLabel)
        messageLabel.text = "Mussum Ipsum, cacilds vidis litro abertis. Posuere libero varius. Nullam a nisl ut ante blandit hendrerit. Aenean sit amet nisi. Quem num gosta di mim que vai caçá sua turmis! Quem num gosta di mé, boa gentis num é. Per aumento de cachacis, eu reclamis."
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBubbblebackgroundView() {
        addSubview(bubbleBackgroundView)
        bubbleBackgroundView.backgroundColor = UIColor.yellow
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //passing label object by reference
    private func constraints(view: inout UIView, labelMessage: inout UILabel) {
        
        let constraints = [labelMessage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                           labelMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           labelMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
                           //bubblebackground constraint
                           view.topAnchor.constraint(equalTo: labelMessage.topAnchor, constant: -16),
                           view.bottomAnchor.constraint(equalTo: labelMessage.bottomAnchor, constant: 16),
                           view.leadingAnchor.constraint(equalTo: labelMessage.leadingAnchor, constant: -16),
                           view.trailingAnchor.constraint(equalTo: labelMessage.trailingAnchor, constant: 16)]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = labelMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint?.isActive = false
        trailingConstraint = labelMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint?.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
