//
//  CircleColor.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/25.
//

import SwiftUI

struct CircleColor {
    var percentage: Double

    static func get(_ percentage: Double) -> Color {
        var red: Double = 1.0
        if percentage > 0.5 {
            red -= (percentage - 0.5) * 2.0
        }
        let green: Double = min(percentage * 2.0, 1.0)
        return Color(red: red, green: green, blue: 0)
    }
}
