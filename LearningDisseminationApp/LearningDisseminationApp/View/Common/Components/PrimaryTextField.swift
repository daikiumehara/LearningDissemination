//
//  PrimaryTextField.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/09.
//

import SwiftUI

struct PrimaryTextField: View {
    @Binding var value: String
    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)

            TextField(text: $value) {
                Text("")
            }
            .textFieldStyle(.roundedBorder)
        }
    }
}

struct PrimaryTextField_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryTextField(value: .constant(""), title: "アカウントID")
    }
}
