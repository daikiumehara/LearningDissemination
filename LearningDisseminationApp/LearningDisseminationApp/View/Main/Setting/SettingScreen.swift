//
//  SettingScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import SwiftUI

struct SettingScreen: View {
    @StateObject var viewModel: SettingViewModel = SettingViewModel()

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        GroupInfoScreen()
                    } label: {
                        Text("グループ情報")
                    }

                    NavigationLink {
                        UserInfoScreen()
                    } label: {
                        Text("名前変更")
                    }

                    NavigationLink {
                        HistoryScreen()
                    } label: {
                        Text("更新履歴")
                    }
                }

                Section {
                    Button {
                        viewModel.leaveGroup()
                    } label: {
                        HStack {
                            Spacer()

                            Text("グループを抜ける")
                                .bold()
                                .foregroundColor(.red)

                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("設定画面")
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
