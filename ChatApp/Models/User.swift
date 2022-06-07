//
//  User.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import UIKit
import RealmSwift

class User: Object {
    
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
