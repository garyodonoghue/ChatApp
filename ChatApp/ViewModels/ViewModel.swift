//
//  ViewModel.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import Foundation

class ViewModel {
    
    static let shared = ViewModel()
    private var conversation: Conversation?
    
    func fetchChatData(completion: () -> Void) {
        let conversation = MessagesDao.shared.getConversation()
        self.conversation = conversation
        completion()
    }
    
    var messageCount: Int {
        return conversation?.messages.count ?? 0
    }
    
    var messages: [Message] {
        guard let messages = conversation?.messages else { return [] }
        return Array(messages)
    }
    
    func addMessage(message: Message) {
        conversation?.messages.insert(message, at: 0)
    }
}
