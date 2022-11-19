//
//  SplashScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/30.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject var viewModel = SplashViewModel()
    var body: some View {
        Text("Hello!")
            .font(.largeTitle)
            .fontWeight(.black)
            .onAppear {
                viewModel.onAppear()
            }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
