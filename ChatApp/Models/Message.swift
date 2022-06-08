//
//  Message.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import Foundation
import RealmSwift

/// Message model. Realm managed object. Used to store info about a mesasge sent from a user in a conversation, such as the user who sent the message,
/// the text content of the message and the date the message was sent
class Message: Object {
    
    @Persisted var user: User?
    @Persisted var text: String
    @Persisted var sentDate: Date
    
    convenience init(user: User, text: String, sendDate: Date){
        self.init()
        self.user = user
        self.text = text
        self.sentDate = sendDate
    }
}

extension Message {
    
    /// Helper function to check if the message was sent by me (Gary)
    func isMe() -> Bool {
        guard let user = user else { return false }
        return user.name == ConversationGenerator.userGary.name
    }
}
