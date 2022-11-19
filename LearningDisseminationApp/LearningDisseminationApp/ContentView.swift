//
//  ContentView.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/07.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState: AppState

    var body: some View {
        switch appState.loginState {
        case .splash:
            SplashScreen()
        case .initial:
            InitialScreen()
        case .group:
            GroupScreen()
        case .main:
            MainScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppContainer.appState)
    }
}
