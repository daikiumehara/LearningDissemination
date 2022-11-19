//
//  GroupInfoScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/28.
//

import SwiftUI

struct GroupInfoScreen: View {
    @StateObject var viewModel = GroupInfoViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("グループID：")
                    .bold()

                Text(viewModel.id)
            }
            .font(.title3)

            HStack {
                Text("パスワード：")
                    .bold()

                Text(viewModel.password)
            }
            .font(.title3)

            VStack {
                PrimaryTextField(value: $viewModel.name, title: "グループ名")
                    .textContentType(.username)

                UnitBasedTextField(value: $viewModel.task, unit: $viewModel.unit, title: "タスクの総量")
                    .frame(height: 60)
            }
            .padding()

            Button {
                viewModel.update()
            } label: {
                Text("変更")
                    .frame(width: 250, height: 50)
                    .primaryStyle()
            }

            Text(viewModel.errorMessage)
                .foregroundColor(.red)
                .bold()

        }
        .navigationTitle("グループ情報の設定")
    }
}

struct GroupInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        GroupInfoScreen()
    }
}
