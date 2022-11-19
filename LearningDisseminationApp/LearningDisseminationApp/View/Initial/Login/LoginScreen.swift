//
//  LoginScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/09.
//

import SwiftUI

struct LoginScreen: View {
    enum Field: Hashable {
        case accountID
        case password
    }

    @StateObject var viewModel: LoginViewModel
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack {
            Text("アカウントにログイン")
                .fontWeight(.black)
                .font(.title)

            VStack {
                PrimaryTextField(value: $viewModel.id, title: "アカウントID")
                    .textContentType(.password)
                    .focused($focusedField, equals: .accountID)

                PasswordTextField(value: $viewModel.password, title: "パスワード")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
            }
            .padding()

            Button {
                viewModel.login()
            } label: {
                Text("ログイン")
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

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(viewModel: AppContainer.loginViewModel)
    }
}
