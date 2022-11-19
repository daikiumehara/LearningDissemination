//
//  HistoryViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/31.
//

import Foundation
import FirebaseDatabase

class HistoryViewModel: ObservableObject {
    @Published var historys = [History]()
    var errorMessage: String = ""

    func fetch() {
        FirebaseUtility.getHistory(groupID: UserCache.group.info.id,
                                   accountID: UserCache.user.id) { [weak self] historys, error in
            guard let historys = historys else {
                if let error = error {
                    self?.errorMessage = error.message
                }
                return
            }
            self?.historys = historys
        }
    }
}
