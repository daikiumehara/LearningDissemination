//
//  TaskInfo.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import Foundation

class TaskInfo: Comparable {
    let user: User
    let task: TaskProgress

    init(user: User, task: TaskProgress) {
        self.user = user
        self.task = task
    }

    static func == (lhs: TaskInfo, rhs: TaskInfo) -> Bool {
        lhs.task.progress == rhs.task.progress
    }

    static func < (lhs: TaskInfo, rhs: TaskInfo) -> Bool {
        lhs.task.progress > rhs.task.progress
    }
}
