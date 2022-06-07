//
//  User.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 07/06/2022.
//

import UIKit

struct User {
    
    let id: String = UUID().uuidString
    let image: UIImage? = nil
    let name: String
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
