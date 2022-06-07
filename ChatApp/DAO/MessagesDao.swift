//
//  Conversation.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import UIKit
import RealmSwift

class MessagesDao {
    
    static var shared = MessagesDao()
    let realm = try! Realm()

    init() {
        loadConversationHistoryIfNeeded()
    }
    
    var messageCount: Int {
        return getMesssages().count
    }

    func getMesssages() -> [Message] {
        guard let conversation = realm.objects(Conversation.self).first else {
            fatalError("Failed to load conversation")
        }
        
        return Array(conversation.messages)
    }
    
    func addMessage(_ message: Message) {
        guard let conversation = realm.objects(Conversation.self).first else {
            fatalError("Failed to load conversation")
        }
        
        try! realm.write {
            conversation.messages.insert(message, at: 0)
        }
    }
    
    func loadConversationHistoryIfNeeded() {
        if realm.objects(Conversation.self).isEmpty {
            let conversation = ConversationGenerator.shared.getConversation()
            
            try! realm.write {
                realm.add(conversation)
            }
        }
    }
}
