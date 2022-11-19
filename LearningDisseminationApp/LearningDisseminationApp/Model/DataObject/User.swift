//
//  User.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import Foundation

class User {
    var id: String
    var name: String
    var password: String

    init(id: String, name: String, password: String) {
        self.id = id
        self.name = name
        self.password = password
    }
}
