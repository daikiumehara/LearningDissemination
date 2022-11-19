//
//  GroupScreen.swift
//  LearningDisseminationApp
//
//  Created by daiki umehara on 2022/10/09.
//

import SwiftUI

struct GroupScreen: View {
    @State var create: Bool = false
    @State var join: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("グループに参加しよう！")
                    .font(.title)
                    .fontWeight(.black)

                Button {
                    join = true
                } label: {
                    Text("グループに参加")
                        .frame(width: 200, height: 50)
                        .primaryStyle()
                }

                Button {
                    create = true
                } label: {
                    Text("グループを作成")
                        .frame(width: 200, height: 50)
                        .primaryStyle()
                }

                NavigationLink(isActive: $join) {
                    GroupJoinScreen(viewModel: AppContainer.groupJoinViewModel)
                } label: { }

                NavigationLink(isActive: $create) {
                    GroupCreateScreen(viewModel: AppContainer.groupCreateViewModel)
                } label: { }
            }
        }
    }
}

struct GroupScreen_Previews: PreviewProvider {
    static var previews: some View {
        GroupScreen()
    }
}
