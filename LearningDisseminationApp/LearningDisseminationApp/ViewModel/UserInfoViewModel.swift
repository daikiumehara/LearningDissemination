//
//  UserInfoViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/29.
//

import Foundation
import FirebaseDatabase

class UserInfoViewModel: ObservableObject {
    var name: String = UserCache.user.name
    @Published var errorMessage: String = ""

    func update() {
        errorMessage = ""
        let ref = Database.database().reference()
        let accountID = UserCache.user.id
        let childUpdates: [String: Any] = ["users/\(accountID)/name": name]
        ref.updateChildValues(childUpdates) { [weak self] error, _ in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = "エラーが発生しました"
            }
        }
    }
}
