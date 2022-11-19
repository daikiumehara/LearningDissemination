//
//  SplashViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/30.
//

import Foundation
import FirebaseDatabase

class SplashViewModel: ObservableObject {
    func onAppear() {
        guard let accountID = UserDefaults.standard.object(forKey: .accountID) as? String else {
            AppContainer.appState.change(.initial)
            return
        }
        FirebaseUtility.getUser(accountID: accountID) { user, error in
            if error != nil {
                return
            }
            guard let user = user else {
                return
            }
            UserCache.user = user

            guard let groupID = UserDefaults.standard.object(forKey: .groupID) as? String else {
                AppContainer.appState.change(.group)
                return
            }
            Task {
                let (group, error) = await FirebaseUtility.getAllData(groupID: groupID)
                if error != nil {
                    DispatchQueue.main.async {
                        AppContainer.appState.change(.group)
                    }
                    return
                }
                guard let group = group else {
                    DispatchQueue.main.async {
                        AppContainer.appState.change(.group)
                    }
                    return
                }
                DispatchQueue.main.async {
                    UserCache.group = group
                    AppContainer.appState.change(.main)
                }
            }
        }
    }
}
