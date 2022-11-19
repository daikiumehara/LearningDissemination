//
//  HistoryRow.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/31.
//

import SwiftUI

struct HistoryRow: View {
    var history: History
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(CustomDataFormatter.string(history.date))
                    .bold()

                Spacer()

                PercentageCircle(percentage: history.percentage, textRatio: 0.2)
                    .frame(width: geometry.size.height, height: geometry.size.height)
            }
        }
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(history: History(id: "", date: Date(), progress: 10, goal: 90))
    }
}
