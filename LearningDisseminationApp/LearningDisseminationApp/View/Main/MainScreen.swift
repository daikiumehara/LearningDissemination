//
//  MainScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import SwiftUI

struct MainScreen: View {
    @State var tabType: MainTabType = .home

    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }

            InputScreen()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("入力")
                }

            SettingScreen()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("設定")
                }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
