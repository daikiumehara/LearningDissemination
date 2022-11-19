//
//  AppState.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import Foundation
import FirebaseDatabase

struct AppContainer {
    static let passwordCount = 4
    static let appState = AppState()

    static let loginViewModel = LoginViewModel()
    static let registrationViewModel = RegistrationViewModel()
    static let groupCreateViewModel = GroupCreateViewModel()
    static let groupJoinViewModel = GroupJoinViewModel()
}

class AppState: ObservableObject {
    @Published var loginState: LoginState = .splash

    enum LoginState {
        case splash
        case initial
        case group
        case main
    }

    func change(_ state: LoginState) {
        self.loginState = state
        self.objectWillChange.send()
    }
}

class UserCache {
    static var user = User(id: "", name: "", password: "")
    static var group = Group(info: GroupInfo(id: "", name: "", password: "", goal: 0, unit: ""), users: [], rankings: [])
}
