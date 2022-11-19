//
//  GroupJoinScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/13.
//

import SwiftUI

struct GroupJoinScreen: View {
    enum Field: Hashable {
        case groupID
        case password
    }

    @FocusState private var focusedField: Field?
    @StateObject var viewModel: GroupJoinViewModel

    var body: some View {
        VStack {
            Text("グループに参加")
                .fontWeight(.black)
                .font(.title)

            VStack {
                PrimaryTextField(value: $viewModel.id, title: "グループID")
                    .textContentType(.password)
                    .focused($focusedField, equals: .groupID)

                PasswordTextField(value: $viewModel.password, title: "パスワード")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
            }
            .padding()

            Button {
                viewModel.joinGroup()
            } label: {
                Text("参加")
                    .frame(width: 250, height: 50)
                    .primaryStyle()
            }

            Text(viewModel.errorMessage)
                .foregroundColor(.red)
                .bold()
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

struct GroupJoinScreen_Previews: PreviewProvider {
    static var previews: some View {
        GroupJoinScreen(viewModel: AppContainer.groupJoinViewModel)
    }
}
