//
//  NumberTextField.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/27.
//

import SwiftUI

struct NumberTextField: View {
    @Binding var num: Int
    @State var numString: String
    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(text: .init(get: {
                numString
            }, set: { str in
                guard let value = Int(str) else {
                    num = 0
                    return
                }
                num = value
                numString = value.description
            })) {
                Text("")
            }
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
        }
    }

    init(num: Binding<Int>, title: String) {
        self._num = num
        self.numString = num.wrappedValue.description
        self.title = title
    }
}

struct NumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        NumberTextField(num: .constant(11), title: "タイトル")
    }
}
