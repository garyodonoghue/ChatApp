//
//  ViewController.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import UIKit
import InputBarAccessoryView

class ViewController: UIViewController {

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
        viewModel.fetchChatData(completion: {
            conversationTableView.reloadData()
        })
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.messages[indexPath.section]
        var isGrouped = false
        
        if indexPath.section + 1 < viewModel.messageCount {
            let message2 = viewModel.messages[indexPath.section + 1]
            let timeDiff = message.sentDate.timeIntervalSince1970 - message2.sentDate.timeIntervalSince1970
            if timeDiff <= 20 && message2.user == message.user {
                isGrouped = true
            }
        }
        
        let sender = message.user.name == "Gary" ? Sender.me : Sender.them
        
        let reuseIdentifier = sender == .me ? "MeMessage" : "ThemMessage"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ChatCell else { return UITableViewCell() }
        cell.configure(withMessage: message, isGrouped: isGrouped)
        // rotate the table view so user scrolls upwards to view history of messages
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section + 1 < viewModel.messageCount else { return 0 }
        let message1 = viewModel.messages[section]
        let message2 = viewModel.messages[section + 1]
        
        let timeDiff = message1.sentDate.timeIntervalSince1970 - message2.sentDate.timeIntervalSince1970
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
        let dateFormatter = DateFormatter()
        

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        
        let calendar = Calendar.current
        if calendar.isDateInToday(message.sentDate) {
            dateFormatter.dateFormat = "HH:mm"
            label.text = "Today \(dateFormatter.string(from: message.sentDate))"
        } else {
            dateFormatter.dateFormat = "EEEE HH:mm"
            label.text = dateFormatter.string(from: message.sentDate)
        }
        
        
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

extension ViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        conversationTableView.beginUpdates()
        viewModel.addMessage(message: Message(user: MessagesDao.userGary, text: text, sentDate: Date.now))
        let indexSet = IndexSet(integer: 0)
        conversationTableView.insertSections(indexSet, with: .bottom)
        conversationTableView.endUpdates()
    }
}
