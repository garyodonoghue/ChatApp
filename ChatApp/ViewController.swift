//
//  ViewController.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var conversationTableView: UITableView!
    private let viewModel = ViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        
        viewModel.fetchChatData(completion: {
            conversationTableView.reloadData()
        })
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.messages[indexPath.row]
        
        let sender = message.user.name == "Gary" ? Sender.me : Sender.them
        
        if sender == .me {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MeMessage") as? MeMessageCell else { return UITableViewCell()
            }
            
            cell.configure(withMessage: message)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThemMessage") as? ThemMessageCell else { return UITableViewCell()
            }
            
            cell.configure(withMessage: message)
            return cell
        }
    }
}

enum Sender { case me, them }

class ThemMessageCell: UITableViewCell {
    
    var sender: Sender?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageText: UILabel!
    
    func configure(withMessage message: Message) {
        messageText.text = message.text
    }
}


class MeMessageCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageText: UILabel!
    
    func configure(withMessage message: Message) {
        messageText.text = message.text
    }
}
