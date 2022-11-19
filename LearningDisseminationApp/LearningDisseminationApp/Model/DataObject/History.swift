//
//  History.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/31.
//

import Foundation

class History: Identifiable, Comparable {
    var id: String
    var date: Date
    var progress: Int
    var goal: Int
    var percentage: Double {
        Double(progress) / Double(goal)
    }

    init(id: String, date: Date, progress: Int, goal: Int) {
        self.id = id
        self.date = date
        self.progress = progress
        self.goal = goal
    }

    static func < (lhs: History, rhs: History) -> Bool {
        lhs.date > rhs.date
    }

    static func == (lhs: History, rhs: History) -> Bool {
        lhs.date == rhs.date
    }
}
