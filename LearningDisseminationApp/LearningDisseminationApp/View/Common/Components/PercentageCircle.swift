//
//  PercentageCircle.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import SwiftUI

struct PercentageCircle: View {
    var percentage: Double
    var textRatio = 0.1
    var color: Color {
        Color(red: 1.0 , green: 0.0, blue: 0.0)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(CircleColor.get(percentage).opacity(0.2))
                    .frame(width: geometry.size.height * 0.8, height: geometry.size.height * 0.8)

                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width * 0.5,
                                          y: geometry.size.height * 0.5))
                    path.addArc(center: CGPoint(x: geometry.size.width * 0.5,
                                                y: geometry.size.height * 0.5),
                                radius: geometry.size.height * 0.4,
                                startAngle: Angle(degrees: -90.0),
                                endAngle: Angle(degrees: -90.0 + 360 * percentage),
                                clockwise: false)
                    path.closeSubpath()
                }
                .fill(CircleColor.get(percentage))

                Circle()
                    .fill(Color.white)
                    .frame(width: geometry.size.height * 0.6)

                Text("\(Int(percentage * 100))%")
                    .foregroundColor(.black)
                    .font(.system(size: geometry.size.height * textRatio))
                    .bold()
            }
        }
    }
}

struct PercentageCircle_Previews: PreviewProvider {
    static var previews: some View {
        PercentageCircle(percentage: 0.5)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
