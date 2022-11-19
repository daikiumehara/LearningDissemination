//
//  Group.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import Foundation

class Group {
    var info: GroupInfo
    var users: [User]
    var rankings: [Ranking]

    init(info: GroupInfo, users: [User], rankings: [Ranking]) {
        self.info = info
        self.users = users
        self.rankings = rankings
    }
}

class GroupInfo: Identifiable {
    var id: String
    var name: String
    var password: String
    var goal: Int
    var unit: String

    init(id: String, name: String, password: String, goal: Int, unit: String) {
        self.id = id
        self.name = name
        self.password = password
        self.goal = goal
        self.unit = unit
    }
}
