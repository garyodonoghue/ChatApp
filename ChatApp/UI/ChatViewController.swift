//
//  ViewController.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import UIKit
import InputBarAccessoryView

class ChatViewController: UIViewController {

    @IBOutlet weak var textInputView: InputBarAccessoryView!
    @IBOutlet weak var conversationTableView: UITableView! {
        didSet {
            // rotate the table view so user scrolls upwards to view history of messages
            conversationTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
    private let viewModel = ViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInputView.delegate = self
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
    }
}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.messages[indexPath.section]
        var isGrouped = false
        
        if indexPath.section + 1 < viewModel.messageCount {
            let previousMessage = viewModel.messages[indexPath.section + 1]
            let timeDiff = message.sentDate.timeIntervalSince1970 - previousMessage.sentDate.timeIntervalSince1970
            if let previousMessageUser = previousMessage.user,
                let initialMessageUser = message.user,
                previousMessageUser.isEqual(initialMessageUser), timeDiff <= 20 {
                isGrouped = true
            }
        }
        
        let sender = message.user?.name == "Gary" ? Sender.me : Sender.them
        
        let reuseIdentifier = sender == .me ? "MeMessage" : "ThemMessage"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ChatCell else { return UITableViewCell() }
        cell.configure(withMessage: message, isGrouped: isGrouped)
        // rotate the table view so user scrolls upwards to view history of messages
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section < viewModel.messageCount - 1 else { return 0 }
        let message1 = viewModel.messages[section]
        let message2 = viewModel.messages[section + 1]
        let timeDiff = viewModel.timeDiffForMessage(message: message1, fromPrevious: message2)
        
        if timeDiff > 3600 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let message = viewModel.messages[section]
        return message.text
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let message = viewModel.messages[section]
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = viewModel.formattedHeaderText(forMessage: message)
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        
        headerView.addSubview(label)
        headerView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.messageCount
    }
}

enum Sender { case me, them }

class ChatCell: UITableViewCell {
    @IBOutlet weak var messageSpacingConstraint: NSLayoutConstraint!
    
    func configure(withMessage message: Message, isGrouped: Bool) {
        if isGrouped {
            messageSpacingConstraint.constant = 2
        } else {
            messageSpacingConstraint.constant = 10
        }
    }
}

class ThemMessageCell: ChatCell {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageText: UILabel!
    
    override func configure(withMessage message: Message, isGrouped: Bool) {
        super.configure(withMessage: message, isGrouped: isGrouped)
        messageText.text = message.text
    }
    
    override func layoutSubviews() {
        bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: 10)
    }
}

class MeMessageCell: ChatCell {
    
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    override func configure(withMessage message: Message, isGrouped: Bool) {
        super.configure(withMessage: message, isGrouped: isGrouped)
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

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        textInputView.inputTextView.text = ""
        conversationTableView.beginUpdates()
        viewModel.addMessage(message: Message(user: ConversationGenerator.userGary, text: text, sendDate: Date.now)) // todo
        let indexSet = IndexSet(integer: 0)
        conversationTableView.insertSections(indexSet, with: .bottom)
        conversationTableView.endUpdates()
    }
}
