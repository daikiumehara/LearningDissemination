//
//  UserInfoScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/28.
//

import SwiftUI

struct UserInfoScreen: View {
    @StateObject var viewModel = UserInfoViewModel()
    @FocusState private var focus: Bool
    var body: some View {
        VStack {
            VStack {
                PrimaryTextField(value: $viewModel.name, title: "アカウント名")
                    .textContentType(.username)
                    .focused($focus)
            }
            .padding()

            Button {
                viewModel.update()
            } label: {
                Text("更新")
                    .frame(width: 250, height: 50)
                    .primaryStyle()
            }

            Text(viewModel.errorMessage)
                .foregroundColor(.red)
                .bold()
        }
        .navigationTitle("ユーザ情報の設定")
        .onTapGesture {
            focus = false
        }
    }
}

struct UserInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoScreen()
    }
}
