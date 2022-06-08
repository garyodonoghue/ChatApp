//
//  ViewController.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import UIKit
import InputBarAccessoryView

/// ChatViewController is used to display the conversation history between two users, and allow input of text to 'send' messages to the other user in the conversation
class ChatViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var textInputView: InputBarAccessoryView!
    @IBOutlet weak var conversationTableView: UITableView! {
        didSet {
            // rotate the table view so user scrolls upwards to view history of messages
            conversationTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
    
    // MARK: Private vars
    private let viewModel = ChatViewModel.shared
    private let meReuseIdentifier = "MeMessage"
    private let themReuseIdentifier = "ThemMessage"
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textInputView.delegate = self
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = viewModel.messages[indexPath.section]
        let isGrouped = viewModel.isGrouped(messageIndex: indexPath.section)
        let reuseIdentifier = message.isMe() ? meReuseIdentifier : themReuseIdentifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? ChatCell else { return UITableViewCell() }
        cell.configure(withMessage: message, isGrouped: isGrouped)
        
        // rotate the table view so user scrolls upwards to view history of messages
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section < viewModel.messageCount - 1 else { return 0 }

        let message = viewModel.messages[section]
        let previousMessage = viewModel.messages[section + 1]
        
        return viewModel.isOneHourTimeDiff(message: message, fromPrevious: previousMessage) ? 20 : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.textForMessage(index: section)
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
}


// MARK: InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        textInputView.inputTextView.text = ""
        conversationTableView.beginUpdates()
        viewModel.saveMessage(message: Message(user: ConversationGenerator.userGary, text: text, sendDate: Date.now)) // todo
        let indexSet = IndexSet(integer: 0)
        conversationTableView.insertSections(indexSet, with: .bottom)
        conversationTableView.endUpdates()
        conversationTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    }
}
