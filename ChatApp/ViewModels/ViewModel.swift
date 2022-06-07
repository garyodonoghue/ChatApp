//
//  ViewModel.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import Foundation

class ViewModel {
    
    static let shared = ViewModel()
    private let messagesDao = MessagesDao.shared
    
    var messageCount: Int {
        return messagesDao.messageCount
    }
    
    var messages: [Message] {
        return messagesDao.getMesssages()
    }
    
    func addMessage(message: Message) {
        messagesDao.addMessage(message)
    }
}
