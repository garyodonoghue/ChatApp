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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Message") as? MessageCell else { return UITableViewCell() }
        
        let message = viewModel.messages[indexPath.row]
        cell.messageText.text = message.text
        cell.side = message.user.name == "Gary" ? .right : .left
        return cell
    }
}


class MessageCell: UITableViewCell {
    
    enum Side { case left, right }
    
    var side: Side?
    
    @IBOutlet weak var messageText: UILabel!
    
    override func layoutSubviews() {
        messageText.textAlignment = side == .left ? .left : .right
        
    }
}
