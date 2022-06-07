//
//  Conversation.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import Foundation
import RealmSwift

class Conversation: Object {
    
    @Persisted(primaryKey: true) var id = 0
    @Persisted var title: String
    @Persisted var messages: List<Message>
    @Persisted var users: List<User>
    
    var lastMessage: Message? { return messages.last }
    
    convenience init(users: [User], messages: [Message]) {
        self.init()
        let usersList = List<User>()
        usersList.append(objectsIn: users)
        self.users = usersList
        
        let messagesList = List<Message>()
        messagesList.append(objectsIn: messages)
        self.messages = messagesList
        self.title = "\(users[0].name) & \(users[1].name)"
    }
}
