//
//  Ranking.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/25.
//

import Foundation

class Ranking: Identifiable {
    var id: String {
        taskInfo.user.id
    }
    var rank: Int
    var taskInfo: TaskInfo

    init(rank: Int, info: TaskInfo) {
        self.rank = rank
        self.taskInfo = info
    }
}
