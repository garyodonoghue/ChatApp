//
//  ViewModel.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 30/05/2022.
//

import Foundation

/// ViewModel associated with the `ChatViewController`. Used to extract the business logic and unnecessary calculations from the UI layer (ViewController)
/// Provides mechanims to read from and write messages to the Database (Realm)
class ChatViewModel {
    
    static let shared = ChatViewModel()
    private let messagesDao = MessagesDao.shared
    
    /// The total count of the messages in the conversation
    var messageCount: Int {
        return messagesDao.messageCount
    }
    
    /// The entire list of messages in the conversation
    var messages: [Message] {
        return messagesDao.getMesssages()
    }
    
    /// Get the text value of the messsage at Index `index` in the conversation history 
    func textForMessage(index: Int) -> String {
        let message = messages[index]
        return message.text
    }
    
    /// Save a new message to the DB
    func saveMessage(message: Message) {
        messagesDao.saveMessage(message)
    }
    
    
    /// Provides the formatted text which should appear above a section of messages. This will display the word 'Today' along with the hour and mins if the message was sent today,
    /// otherwise it will just display the day followed by the hours and mins
    ///
    /// - Parameter message:the message for which we are getting the header value for
    /// - Returns: The formatted section header text, in the format {day} {hh:mm} , where `day` is either 'Today' ot the day of the week if not today
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
    
    
    
    /// Check if there is an hour or mores time difference in the sent dates of the two messages
    /// - Parameters:
    ///   - message: the 'current' message, i.e. the current message in focus
    ///   - previousMessage: the 'previous' message to the current message in the conversation history
    /// - Returns:  Returns true if there is an hour or mores time difference in the sent dates of the two messages
    func isOneHourTimeDiff(message: Message, fromPrevious previousMessage: Message) -> Bool {
        return timeDiffForMessage(message: message, fromPrevious: previousMessage) > 3600
    }
    
    
    /// Gets the time difference between the send times of two messages
    /// - Parameters:
    ///   - message: the 'current' message, i.e. the current message in focus
    ///   - previousMessage: the 'previous' message to the current message in the conversation history
    /// - Returns: The time difference in seconds between the send times of the two messages, expressed as a `Double`
    func timeDiffForMessage(message: Message, fromPrevious previousMessage: Message) -> Double {
        return message.sentDate.timeIntervalSince1970 - previousMessage.sentDate.timeIntervalSince1970
    }
    
    
    /// Check whether a message should be grouped with it's previous message in the conversation history
    /// Grouping of two messages is determined by whether they both came from the same user and they were sent only 20 seconds apart
    /// - Parameter messageIndex: The index of the message in the conversation history
    /// - Returns: Whether or not this message should appear as grouped or not
    func isGrouped(messageIndex: Int) -> Bool {
        var isGrouped = false
        
        if messageIndex + 1 < messageCount {
            let message = messages[messageIndex]
            let previousMessage = messages[messageIndex + 1]
            let timeDiff = timeDiffForMessage(message: message, fromPrevious: previousMessage)
            
            if let previousMessageUser = previousMessage.user,
                let initialMessageUser = message.user,
                previousMessageUser.isEqual(initialMessageUser), timeDiff <= 20 {
                isGrouped = true
            }
        }
        
        return isGrouped
    }
}
