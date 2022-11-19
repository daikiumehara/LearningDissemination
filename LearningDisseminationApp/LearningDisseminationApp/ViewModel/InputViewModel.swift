//
//  InputViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/25.
//

import Foundation
import FirebaseDatabase

class InputViewModel: ObservableObject {
    var progress: Int {
        get {
            return priProgress
        }
        set {
            if newValue <= goal {
                priProgress = newValue
            } else {
                priProgress = goal
            }
            self.objectWillChange.send()
        }
    }
    private var priProgress: Int = 0
    var percentage: Double {
        Double(priProgress) / Double(goal)
    }
    @Published var unit: String = UserCache.group.info.unit
    @Published var goal: Int = UserCache.group.info.goal
    @Published var errorMessage: String = ""
    @Published var disable = false

    func updateCircle() {
        self.unit = UserCache.group.info.unit
        if let index = UserCache.group.rankings.firstIndex (where: { ranking in
            ranking.taskInfo.user.id == UserCache.user.id
        }) {
            self.progress = UserCache.group.rankings[index].taskInfo.task.progress
        }
    }

    func update() {
        disable = true
        errorMessage = ""
        goal = UserCache.group.info.goal
        unit = UserCache.group.info.unit
        let task = FirebaseUtility.makeTask(progress: progress)
        let ref = Database.database().reference()
        FirebaseUtility.setTask(groupID: UserCache.group.info.id, accountID: UserCache.user.id, task: task) { [weak self] error, _ in
            if let error = error {
                self?.errorMessage = "エラーが発生しました"
                return
            }
            self?.disable = false
            // TODO: 成功したことがわかるUI表示
        }
    }
}
