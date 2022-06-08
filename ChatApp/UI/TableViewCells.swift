//
//  TableViewCells.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 08/06/2022.
//

import UIKit

/// ChatCell is a base class used for common setup between the ThemMessageCell and MeMessageCell child classes
class ChatCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var messageSpacingConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    // MARK: Setup
    func configure(withMessage message: Message, isGrouped: Bool) {
        messageText.text = message.text
        
        if isGrouped {
            messageSpacingConstraint.constant = 2
        } else {
            messageSpacingConstraint.constant = 10
        }
    }
}

/// ThemMessageCell is used to display messages from the ''other" user in the conversation, i.e. the user that is not Gary
class ThemMessageCell: ChatCell {
    
    override func layoutSubviews() {
        bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: 10)
    }
}

/// MeMessageCell is used to display messages from me in the  conversation, i.e. the user that is Gary
class MeMessageCell: ChatCell {
    
    override func layoutSubviews() {
        bubbleView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 10)
    }
}
