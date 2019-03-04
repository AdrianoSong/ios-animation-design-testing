//
//  ViewController.swift
//  SampleMessageApp
//
//  Created by Adriano Song on 05/12/18.
//  Copyright © 2018 Adriano Song. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let cellID = "myCell"
    private var chatMessages = [[ChatMessage]]()
    
    private let messagesFromServer = [
        
        ChatMessage(text: "here is my first message", inComing: true, date: Date.dateFromCustomString(customString: "10/08/1986")),
        ChatMessage(text: "here is my reply message for a long more message to show at the screen, here is my reply message for a long more message to show at the screen", inComing: false, date: Date.dateFromCustomString(customString: "10/08/1986")),
        ChatMessage(text: "my reply from repy", inComing: true, date: Date.dateFromCustomString(customString: "11/08/1986")),
        ChatMessage(text: "yo dog", inComing: false, date: Date.dateFromCustomString(customString: "11/08/1986")),
        ChatMessage(text: "my reply from repy", inComing: true, date: Date.dateFromCustomString(customString: "11/08/1986")),
        ChatMessage(text: "yo dog", inComing: false, date: Date.dateFromCustomString(customString: "11/08/1986")),
        ChatMessage(text: "my reply from repy", inComing: true, date: Date.dateFromCustomString(customString: "12/08/1986")),
        ChatMessage(text: "yo dog", inComing: false, date: Date.dateFromCustomString(customString: "12/08/1986")),
        ChatMessage(text: "my reply from repy", inComing: true, date: Date.dateFromCustomString(customString: "12/08/1986")),
        ChatMessage(text: "yo dog", inComing: false, date: Date.dateFromCustomString(customString: "12/08/1986"))
    ]
    
    private func attemptToGroupMessagesByDate() {
        
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date ?? Date()
        }
        
        //sort
        let sortedKeys = groupedMessages.keys.sorted()
        
        sortedKeys.forEach { (key) in
            
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
    }
    
    @objc
    private func goToNextViewController(){
        
        navigationController?.popViewController(animated: true)
    }
    
    private func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.frame.height
        
        var delayCounter = 0
        
        cells.forEach { (cell) in
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        cells.forEach { (cell) in
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            
            delayCounter += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.title = "Message Screen"
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellID)
        
        attemptToGroupMessagesByDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        animateTable()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMesageInSection = chatMessages[section].first,
            let firstDateInMessage = firstMesageInSection.date {
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateStringFormat = dateFormatter.string(from: firstDateInMessage)
        
            let label  = DateHeaderLabel()
            
            label.text = dateStringFormat
            
            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if chatMessages.count - 1 == section {
            
            let myButton = UIButton()
            myButton.setTitle("pop ViewController", for: .normal)
            myButton.setTitleColor(UIColor.white, for: .normal)
            myButton.backgroundColor = UIColor.blue
            myButton.addTarget(self, action: #selector(goToNextViewController), for: .touchUpInside)
        
            return myButton
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if chatMessages.count - 1 == section {
            return 40

        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MessageCell
        cell.messageLabel.text = chatMessages[indexPath.section][indexPath.row].text
        cell.isIncoming = chatMessages[indexPath.section][indexPath.row].inComing
        return cell
    }
}
