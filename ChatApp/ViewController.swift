//
//  ViewController.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var conversationTableView: UITableView! {
        didSet {
            // rotate the table view so user scrolls upwards to view history of messages
            conversationTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
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
        
        let reuseIdentifier = sender == .me ? "MeMessage" : "ThemMessage"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ChatCell else { return UITableViewCell() }
        cell.configure(withMessage: message)
        // rotate the table view so user scrolls upwards to view history of messages
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
}

enum Sender { case me, them }

class ChatCell: UITableViewCell {
    func configure(withMessage message: Message) {
        fatalError("not implemented")
    }
}

class ThemMessageCell: ChatCell {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageText: UILabel!
    
    override func configure(withMessage message: Message) {
        messageText.text = message.text
    }
    
    override func layoutSubviews() {
        bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: 10)
    }
}


class MeMessageCell: ChatCell {
    
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    override func configure(withMessage message: Message) {
        messageText.text = message.text
    }
    
    override func layoutSubviews() {
        bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 10)
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
