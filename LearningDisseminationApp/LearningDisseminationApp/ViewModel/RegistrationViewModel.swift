//
//  RegistrationViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import Foundation
import FirebaseDatabase

class RegistrationViewModel: ObservableObject {
    @Published var hidePassword: Bool = true
    @Published var hideCheckPassword: Bool = true
    var name: String = ""
    var id: String = ""
    var password: String = ""
    var checkPassword: String = ""
    @Published var errorMessage: String = ""

    func createAccount() {
        errorMessage = ""

        guard checkFormat() else {
            return
        }

        let user = [
            "name": name,
            "password": password
        ]

        checkExistAccount { [weak self] ref in
            guard let self = self else { return }
            ref.child("users").child(self.id).setValue(user) { error, _ in
                if error != nil {
                    self.errorMessage = "エラーが発生しました/n通信環境を整えて再度実行してください"
                } else {
                    UserDefaults.standard.setValue(self.id, forKey: .accountID)
                    UserCache.user = User(id: self.id,
                                          name: self.name,
                                          password: self.password)
                    AppContainer.appState.loginState = .group
                    AppContainer.appState.objectWillChange.send()
                }
            }
        }
    }

    func checkFormat() -> Bool {
        guard !name.isEmpty else {
            errorMessage = "名前が入力されていません"
            return false
        }

        guard !id.isEmpty else {
            errorMessage = "アカウントIDが入力されていません"
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

        return true
    }

    func checkExistAccount(completion: @escaping (DatabaseReference) -> Void) {
        let ref = Database.database().reference()
        ref.child("users/\(id)").getData { [weak self] error, snapshot in
            guard error == nil else {
                self?.errorMessage = "エラーが発生しました"
                return
            }
            if let value = snapshot?.value as? [String: String] {

                self?.errorMessage = "同じアカウントIDが登録されています"
                return
            }
            completion(ref)
        }
    }
}
