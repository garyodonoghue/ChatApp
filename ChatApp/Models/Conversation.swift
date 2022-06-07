//
//  Conversation.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import Foundation

class Conversation {
    
    let title: String
    var messages: [Message]
    var users: [User]
    
    var lastMessage: Message? { return messages.last }
    
    init(users: [User], messages: [Message]) {
        self.users = users
        self.messages = messages
        self.title = Lorem.words(nbWords: 4).capitalized
    }
}
