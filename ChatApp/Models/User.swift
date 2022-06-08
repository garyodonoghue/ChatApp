//
//  User.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import UIKit
import RealmSwift

/// User model. Realm managed object. Used to identify the two  users in a `Conversation.swift`
class User: Object {
    
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    func isEqual(_ user: User) -> Bool {
        return name == user.name
    }
}
