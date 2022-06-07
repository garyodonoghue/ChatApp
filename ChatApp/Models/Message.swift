//
//  Message.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import Foundation
import RealmSwift

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
