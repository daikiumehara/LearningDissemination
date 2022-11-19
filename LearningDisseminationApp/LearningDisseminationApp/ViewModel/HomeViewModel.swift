//
//  HomeViewModel.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/27.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var list = [Ranking]()
    @Published var isError = false

    func fetchData() {
        Task {
            let (group, error) = await FirebaseUtility.getAllData(groupID: UserCache.group.info.id)
            if error != nil {
                DispatchQueue.main.async {
                    self.isError.toggle()
                }
                return
            }
            guard let group = group else {
                DispatchQueue.main.async {
                    self.isError.toggle()
                }
                return
            }

            DispatchQueue.main.async {
                UserCache.group = group
                self.list = group.rankings
                self.objectWillChange.send()
            }
        }
    }
}
