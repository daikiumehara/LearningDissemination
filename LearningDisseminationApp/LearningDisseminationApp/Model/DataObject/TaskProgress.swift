//
//  Task.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import Foundation

class TaskProgress {
    var progress: Int
    var goal: Int
    var unit: String

    init(progress: Int, goal: Int, unit: String) {
        self.progress = progress
        self.goal = goal
        self.unit = unit
    }
}
