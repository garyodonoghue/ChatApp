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


    func getConversation() -> Conversation {
        loadConversationHistoryIfNeeded()
        
        guard let conversation = realm.objects(Conversation.self).first else {
            fatalError("Failed to load conversation into Realm DB")
        }
        
        return conversation
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
