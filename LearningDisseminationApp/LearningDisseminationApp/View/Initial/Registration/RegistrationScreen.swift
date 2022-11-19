//
//  RegistrationScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/09.
//

import SwiftUI

struct RegistrationScreen: View {
    enum Field: Hashable {
        case username
        case accountID
        case password
        case checkPassword
    }

    @StateObject var viewModel: RegistrationViewModel
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack {
            Text("アカウントを作成")
                .fontWeight(.black)
                .font(.title)

            VStack {
                PrimaryTextField(value: $viewModel.name, title: "アカウント名")
                    .textContentType(.name)
                    .focused($focusedField, equals: .username)

                PrimaryTextField(value: $viewModel.id, title: "アカウントID")
                    .textContentType(.password)
                    .focused($focusedField, equals: .accountID)

                PasswordTextField(value: $viewModel.password, title: "パスワード")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)

                PasswordTextField(value: $viewModel.checkPassword, title: "パスワード確認用")
                    .textContentType(.password)
                    .focused($focusedField, equals: .checkPassword)
            }
            .padding()

            Button {
                viewModel.createAccount()
            } label: {
                Text("作成")
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

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen(viewModel: AppContainer.registrationViewModel)
    }
}
