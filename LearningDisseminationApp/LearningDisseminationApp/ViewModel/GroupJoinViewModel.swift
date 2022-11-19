//
//  GroupJoinViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/16.
//

import Foundation
import FirebaseDatabase

class GroupJoinViewModel: ObservableObject {
    var id: String = ""
    var password: String = ""
    @Published var errorMessage: String = ""

    func joinGroup() {
        errorMessage = ""

        guard checkFormat() else {
            return
        }

        Task {
            let (group, error) = await FirebaseUtility.getAllData(groupID: id)
            if let error = error {
                self.changeMessage(error.message)
                return
            }
            guard let group = group else {
                self.changeMessage("グループが存在しません")
                return
            }

            FirebaseUtility.existUser(groupID: self.id, accoutID: UserCache.user.id) { [weak self] isExist, error in
                guard let self = self else { return }
                if let error = error {
                    self.changeMessage(error.message)
                    return
                }
                UserDefaults.standard.setValue(self.id, forKey: .groupID)
                if isExist! {
                    print(group.info.id.description)
                    UserCache.group = group
                    AppContainer.appState.loginState = .main
                    AppContainer.appState.objectWillChange.send()
                } else {
                    let task = FirebaseUtility.makeTask(progress: 0)
                    FirebaseUtility.setTask(groupID: self.id, accountID: UserCache
                        .user.id, task: task) { error, _ in
                            if error != nil {
                                self.changeMessage("エラーが発生しました")
                                return
                            } else {
                                DispatchQueue.main.async {
                                    group.users.append(UserCache.user)
                                    group.rankings.append(
                                        Ranking(rank: group.rankings.count+1,
                                                info: TaskInfo(user: UserCache.user,
                                                               task: TaskProgress(progress: 0, goal: group.info.goal, unit: group.info.unit)))
                                    )
                                    UserCache.group = group
                                    AppContainer.appState.loginState = .main
                                    AppContainer.appState.objectWillChange.send()
                                }
                            }
                        }
                }
            }
        }
    }

    private func checkFormat() -> Bool {
        guard !id.isEmpty else {
            errorMessage = "アカウントIDが入力されていません"
            return false
        }

        guard !password.isEmpty else {
            errorMessage = "パスワードが入力されていません"
            return false
        }

        return true
    }

    private func changeMessage(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
}
