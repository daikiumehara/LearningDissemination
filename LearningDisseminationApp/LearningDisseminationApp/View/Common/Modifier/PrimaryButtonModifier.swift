//
//  ButtonModifier.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/09.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .black))
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10)
    }
}

extension View {
    func primaryStyle() -> some View {
        self.modifier(PrimaryButtonModifier())
    }
}
