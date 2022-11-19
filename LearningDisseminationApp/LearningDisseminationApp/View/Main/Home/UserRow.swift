//
//  TopUserRow.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/25.
//

import SwiftUI

struct UserRow: View {
    var ranking: Ranking

    var body: some View {
        GeometryReader { geometry in
            HStack {
                RankView(rank: ranking.rank)
                    .frame(width: geometry.size.height,
                           height: geometry.size.height)

                VStack(alignment: .leading, spacing: 0) {
                    Text(ranking.taskInfo.user.name)
                        .font(.title3)

                    Text(ranking.taskInfo.user.id)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                Spacer()

                PercentageCircle(percentage: Double(ranking.taskInfo.task.progress) / Double(ranking.taskInfo.task.goal), textRatio: 0.2)
                    .frame(width: geometry.size.height,
                           height: geometry.size.height)
            }
        }
        .padding([.bottom, .top], 5)
    }
}

struct TopUserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(ranking: Ranking(rank: 4,
                                    info: TaskInfo(user: User(id: "daikiumehara", name: "だいき", password: ""),
                                                   task: TaskProgress(progress: 123, goal: 250, unit: "ページ"))))
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
