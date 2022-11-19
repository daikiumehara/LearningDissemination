//
//  HomeScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.list) { ranking in
                    UserRow(ranking: ranking)
                    .frame(height: 80)
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.fetchData()
            }
            .alert("エラーが発生しました", isPresented: $viewModel.isError) {
                Button("OK") {
                    viewModel.isError = false
                }
                Button("再試行") {
                    viewModel.fetchData()
                    viewModel.isError = false
                }
            }
            .navigationTitle("ランキング")
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
