//
//  Conversation.swift
//  ChatApp
//
//  Created by gary.odonoghue on 07/06/2022.
//

import Foundation
import RealmSwift

/// Conversation model. Realm managed object. Used to store info about the conversation between two users, including the users involved and their chat history.
class Conversation: Object {
    
    @Persisted(primaryKey: true) var id = 0
    @Persisted var messages: List<Message>
    @Persisted var users: List<User>
        
    convenience init(users: [User], messages: [Message]) {
        self.init()
        let usersList = List<User>()
        usersList.append(objectsIn: users)
        self.users = usersList
        
        let messagesList = List<Message>()
        messagesList.append(objectsIn: messages)
        self.messages = messagesList
    }
}
