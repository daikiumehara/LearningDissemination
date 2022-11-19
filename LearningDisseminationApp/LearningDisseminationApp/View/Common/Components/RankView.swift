//
//  RankView.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/25.
//

import SwiftUI

struct RankView: View {
    var rank: Int
    var body: some View {
        ZStack(alignment: .center) {
            switch rank {
            case 1:
                Image("gold")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: 7)
            case 2:
                Image("silver")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: 7)
            case 3:
                Image("bronze")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: 7)
            default: EmptyView()
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 0) {
                Text(rank.description)
                    .font(.title)
                    .bold()
                Text("位")
            }
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView(rank: 1)
    }
}
