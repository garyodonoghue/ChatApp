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
    
    func formattedHeaderText(forMessage message: Message) -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(message.sentDate) {
            dateFormatter.dateFormat = "HH:mm"
            return "Today \(dateFormatter.string(from: message.sentDate))"
        } else {
            dateFormatter.dateFormat = "EEEE HH:mm"
            return dateFormatter.string(from: message.sentDate)
        }
    }
    
    func timeDiffForMessage(message: Message, fromPrevious previousMessage: Message) -> Double {
        return message.sentDate.timeIntervalSince1970 - previousMessage.sentDate.timeIntervalSince1970
    }
}
