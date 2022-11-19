//
//  GroupCreateScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/13.
//

import SwiftUI

struct GroupCreateScreen: View {
    enum Field: Hashable {
        case groupName
        case password
        case checkPassword
        case task
    }

    @FocusState private var focusedField: Field?
    @StateObject var viewModel: GroupCreateViewModel

    var body: some View {
        VStack {
            Text("グループを作成")
                .fontWeight(.black)
                .font(.title)

            VStack {
                PrimaryTextField(value: $viewModel.name, title: "グループ名")
                    .textContentType(.username)
                    .focused($focusedField, equals: .groupName)

                PasswordTextField(value: $viewModel.password, title: "パスワード")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)

                PasswordTextField(value: $viewModel.checkPassword, title: "パスワード確認用")
                    .textContentType(.password)
                    .focused($focusedField, equals: .checkPassword)

                UnitBasedTextField(value: $viewModel.task, unit: $viewModel.unit, title: "タスクの総量")
                    .focused($focusedField, equals: .task)
                    .frame(height: 60)
            }
            .padding()

            Button {
                viewModel.create()
            } label: {
                Text("作成")
                    .frame(width: 250, height: 50)
                    .primaryStyle()
            }

            Text(viewModel.errorMessage)
                .foregroundColor(.red)
                .bold()
        }
    }
}

struct GroupCreateScreen_Previews: PreviewProvider {
    static var previews: some View {
        GroupCreateScreen(viewModel: AppContainer.groupCreateViewModel)
    }
}
