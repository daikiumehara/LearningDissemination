//
//  InitialScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/09.
//

import SwiftUI

struct InitialScreen: View {
    @State var login: Bool = false
    @State var registration: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("アプリ名")
                    .fontWeight(.black)
                    .font(.title)

                Button {
                    login = true
                } label: {
                    Text("ログイン")
                        .frame(width: 200, height: 50)
                        .primaryStyle()
                }

                Button {
                    registration = true
                } label: {
                    Text("新規登録")
                        .frame(width: 200, height: 50)
                        .primaryStyle()
                }

                NavigationLink(isActive: $login) {
                    LoginScreen(viewModel: AppContainer.loginViewModel)
                } label: { }

                NavigationLink(isActive: $registration) {
                    RegistrationScreen(viewModel: AppContainer.registrationViewModel)
                } label: { }
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialScreen()
    }
}
