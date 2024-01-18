//
//  HomeView.swift
//  UMCProject_Won
//
//  Created by 김승원 on 2024/01/10.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // for CalendarView
        @State var currentDate: Date = Date()
        ScrollView(showsIndicators: false) {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .position(x: UIScreen.main.bounds.width/2, y: 119)
                
                VStack(spacing: 0) {
                    HomeNavigationBarView().padding(.top, 16)
                    UserInformationView().padding(.top, 8)
                    AnnouncementView().padding(.top, 8)
                    MainCalendarView(currentDate: $currentDate).padding(.top, 8)
                    ToDoListView().padding(.top, 24)
                    
                    HStack(spacing: 18) {
                        TodayILearnedView()
                        GitHubView()
                    }
                    .padding(.top, 24)
                    
                    HStack(spacing: 18) {
                        MascotView()
                        RankView()
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .background(Color.background)
    }
}

#Preview {
    HomeView()
}
