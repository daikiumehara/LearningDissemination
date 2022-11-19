//
//  LoginViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/16.
//

import Foundation
import FirebaseDatabase

class LoginViewModel: ObservableObject {
    var id: String = ""
    var password: String = ""
    @Published var errorMessage: String = ""

    func login() {
        errorMessage = ""

        guard checkFormat() else {
            return
        }

        let ref = Database.database().reference()
        ref.child("users/\(id)").getData { [weak self] error, snapshot in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = "エラーが発生しました"
                return
            }
            guard let value = snapshot?.value as? [String: Any] else {
                self.errorMessage = "アカウントが存在しません"
                return
            }
            guard let password = value["password"] as? String else {
                self.errorMessage = "想定外のエラーが発生しました"
                return
            }
            guard self.password == password else {
                self.errorMessage = "パスワードが間違っています"
                return
            }
            let name = value["name"] as? String ?? ""
            UserDefaults.standard.setValue(self.id, forKey: .accountID)
            UserCache.user = User(id: self.id,
                                  name: name,
                                  password: self.password)
            AppContainer.appState.loginState = .group
            AppContainer.appState.objectWillChange.send()
        }
    }

    func checkFormat() -> Bool {
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
}
