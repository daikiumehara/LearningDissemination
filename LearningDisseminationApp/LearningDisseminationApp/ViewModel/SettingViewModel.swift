//
//  SettingViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/27.
//

import Foundation
import FirebaseDatabase

class SettingViewModel: ObservableObject {
    @Published var isError = false

    func leaveGroup() {
        UserDefaults.standard.removeObject(forkey: .groupID)
        AppContainer.appState.loginState = .group
        AppContainer.appState.objectWillChange.send()
    }
}
