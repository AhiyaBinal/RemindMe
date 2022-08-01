//
//  Friend.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-31.
//

import UIKit

class Friend {
    var name : String
    var surname : String
    var relation: String
    var DOB: String
    var DOA: String
    var phone: String
    var email : String
    init(name: String, surname: String, relation: String ,DOB: String ,DOA: String ,phone: String ,email : String ) {
        self.name = name
        self.surname = surname
        self.relation = relation
        self.DOB = DOB
        self.DOA = DOA
        self.phone = phone
        self.email = email
    }
}
