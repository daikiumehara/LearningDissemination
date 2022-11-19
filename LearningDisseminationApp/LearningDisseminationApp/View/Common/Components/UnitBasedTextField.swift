//
//  UnitBasedTextField.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/13.
//

import SwiftUI

struct UnitBasedTextField: View {
    @Binding var value: Int
    @Binding var unit: String
    var title: String

    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)

                    NumberTextField(num: $value, title: "123")
                }
                .frame(width: geometry.size.width * 0.7)

                VStack(alignment: .leading, spacing: 5) {
                    Text("単位")

                    TextField(text: $unit) {
                        Text("例) ページ")
                    }
                    .textFieldStyle(.roundedBorder)
                }
            }
        }
    }
}

struct UnitBasedTextField_Previews: PreviewProvider {
    static var previews: some View {
        UnitBasedTextField(value: .constant(0), unit: .constant(""), title: "タスクの総量")
    }
}
