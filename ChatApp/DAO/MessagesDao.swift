//
//  Conversation.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import UIKit
import RealmSwift

/// MessagesDao is a class used as the Data Access layer in the application. It is  used to read and write messages to the DB (which uses Realm in this application).
class MessagesDao {
    
    static var shared = MessagesDao()
    let realm = try! Realm()

    /// On init of this object (singleton), we check to see if we need to load in chat history or not, this will only be done once per application installation, and is used to setup the application with dummy data
    /// so that we can view conversation history. Once this is loaded into the DB (Realm), all further reads/writes interact with the Realm datastore.
    init() {
        loadConversationHistoryIfNeeded()
    }
    
    /// Retrieve the count of the number of messsages
    var messageCount: Int {
        return getMesssages().count
    }

    /// Retrieve the list of messages stored in the Realm DB
    func getMesssages() -> [Message] {
        guard let conversation = realm.objects(Conversation.self).first else {
            fatalError("Failed to load conversation")
        }
        
        return Array(conversation.messages)
    }
    
    /// Save a new message in the DB. This adds a new message to the conversations' list of messages.
    func saveMessage(_ message: Message) {
        guard let conversation = realm.objects(Conversation.self).first else {
            fatalError("Failed to load conversation")
        }
        
        try! realm.write {
            conversation.messages.insert(message, at: 0)
        }
    }
    
    /// Load dummy conversation data into the DB if needed, i.e. if it has not been done yet for this application.
    func loadConversationHistoryIfNeeded() {
        if realm.objects(Conversation.self).isEmpty {
            let conversation = ConversationGenerator.shared.getConversation()
            
            try! realm.write {
                realm.add(conversation)
            }
        }
    }
}
