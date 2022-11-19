//
//  PasswordTextField.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var value: String
    var title: String
    @State var isHide: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)

            HStack {
                SecureField(text: $value) {
                    Text("\(AppContainer.passwordCount.description)文字以上")
                }
                .textFieldStyle(.roundedBorder)
                .textContentType(.password)
            }
        }
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(value: .constant(""), title: "タイトル")
    }
}
