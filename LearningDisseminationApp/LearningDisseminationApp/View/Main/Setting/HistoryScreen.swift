//
//  HistoryScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/28.
//

import SwiftUI

struct HistoryScreen: View {
    @StateObject var viewModel = HistoryViewModel()
    var body: some View {
        List(viewModel.historys) { history in
            HistoryRow(history: history)
                .frame(height: 60)
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.fetch()
        }
    }
}

struct HIstoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
