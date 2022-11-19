//
//  GroupCreateViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/16.
//

import Foundation
import FirebaseDatabase

class GroupCreateViewModel: ObservableObject {
    var name: String = ""
    var password: String = ""
    var checkPassword: String = ""
    var task: Int = 0
    var unit: String = ""
    @Published var errorMessage: String = ""

    func create() {
        errorMessage = ""

        guard checkFormat() else {
            return
        }

        createGroup { [weak self] id, ref in
            guard let self = self else { return }
            let task = FirebaseUtility.makeTask(progress: 0)
            FirebaseUtility.setTask(groupID: id, accountID: UserCache.user.id, task: task) { error, _ in
                if error != nil {
                    self.errorMessage = "エラーが発生しました"
                    return
                }
                UserDefaults.standard.setValue(id, forKey: .groupID)
                UserCache.group = Group(info: GroupInfo(id: id,
                                            name: self.name,
                                            password: self.password,
                                            goal: self.task,
                                            unit: self.unit),
                                            users: [UserCache.user],
                                            rankings: [Ranking(rank: 1, info: TaskInfo(user: UserCache.user, task: TaskProgress(progress: 0, goal: self.task, unit: self.unit)))])
                AppContainer.appState.change(.main)
            }
        }
    }

    func createGroup(completion: @escaping (String, DatabaseReference) -> Void) {
        let group: [String: Any] = [
            "name": name,
            "password": password,
            "task": task,
            "unit": unit,
            "members": []
        ]
        let ref = Database.database().reference()
        let id = GroupIDGenerator.generator()
        ref.child("groups/").child(id).setValue(group) { [weak self] error, _ in
            if error != nil {
                self?.errorMessage = "エラーが発生しました"
                return
            } else {
                completion(id, ref)
            }
        }
    }

    func checkFormat() -> Bool {
        guard !name.isEmpty else {
            errorMessage = "名前が入力されていません"
            return false
        }

        guard !password.isEmpty else {
            errorMessage = "パスワードが入力されていません"
            return false
        }

        guard password.count >= AppContainer.passwordCount else {
            errorMessage = "パスワードが短すぎます"
            return false
        }

        guard password == checkPassword else {
            errorMessage = "パスワードが一致しません"
            return false
        }

        guard !unit.isEmpty else {
            errorMessage = "単位が入力されていません"
            return false
        }

        return true
    }
}
