//
//  InputScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/14.
//

import SwiftUI

struct InputScreen: View {
    @StateObject var viewModel = InputViewModel()
    @FocusState private var focus: Bool

    var body: some View {
        NavigationView {
            VStack {
                PercentageCircle(percentage: viewModel.percentage)
                    .aspectRatio(contentMode: .fit)

                HStack(alignment: .center) {
                    NumberTextField(num: $viewModel.progress, title: "")
                        .focused($focus)

                    Text("/ \(viewModel.goal)\(viewModel.unit)")
                }
                .padding()

                Button {
                    viewModel.update()
                } label: {
                    Text("更新")
                        .frame(width: 200, height: 50)
                        .primaryStyle()
                }
                .disabled(viewModel.disable)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.updateCircle()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .onTapGesture {
                focus = false
            }
        }
    }
}

struct InputScreen_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen()
    }
}
