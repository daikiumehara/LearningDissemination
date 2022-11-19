//
//  GroupInfoViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/29.
//

import Foundation
import FirebaseDatabase

class GroupInfoViewModel: ObservableObject {
    var id: String = UserCache.group.info.id
    var password: String = UserCache.group.info.password
    var name: String = UserCache.group.info.name
    var task: Int = UserCache.group.info.goal
    var unit: String = UserCache.group.info.unit
    @Published var errorMessage: String = ""

    func update() {
        errorMessage = ""
        let ref = Database.database().reference()
        let groupID = UserCache.group.info.id
        let childUpdates: [String: Any] = ["name": name,
                                           "task": task,
                                           "unit": unit]
        ref.child("groups/\(groupID)").updateChildValues(childUpdates) { [weak self] error, _ in
            guard let self = self else { return }
            if error != nil {
                self.errorMessage = "エラーが発生しました"
            }
        }
    }
}
