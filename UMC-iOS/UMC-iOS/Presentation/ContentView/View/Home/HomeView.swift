//
//  HomeView.swift
//  UMCProject_Won
//
//  Created by 김승원 on 2024/01/10.
//

import SwiftUI

struct HomeView: View {
    // for CalendarView
    @State var currentDate: Date = Date()
    
    @State var shouldShowCalendarPopup: Bool = false// 팝업 뷰 State변수
    
    func createPopup() -> some View { // 팝업 뷰 만드는 함수
        var popupDate: String = ""
        var popupTitle: String = ""
        var popupMainText: String = ""
        var popupWriter: String = ""
        
        if let task = tasks.first(where: { taskIndex in
            return isSameDay(date1: taskIndex.taskDate, date2: currentDate)
        }) {
            for index in task.task {
                popupDate = formattedDateString(date: currentDate)
                popupTitle = index.title
                popupMainText = index.mainText
                popupWriter = "from.회장 \(index.writer)"
            }
        } else {
            popupDate = ""
            popupTitle = ""
            popupMainText = ""
            popupWriter = ""
        }
        
        return ZStack {
            Rectangle()
                .cornerRadius(14.0)
                .frame(width: .infinity, height: 208)
                .padding(.horizontal, 48)
                .foregroundColor(.white)
            
            VStack(spacing: 0) {
                
                Text("\(popupDate)")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color.main2)
                
                Text(popupTitle)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color.main2)
                    .padding(.top, 6)
                
                Text(popupMainText)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.top, 16)
                
                Text(popupWriter)
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(Color.tdlGray)
                    .padding(.top, 8)
                
                Button {
                    self.shouldShowCalendarPopup = false
                } label : {
                    Text("닫기")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(Color.tdlGray)
                } // Button
                .padding(.top, 24)
                
            } // VStack
            
        } // ZStack
        .multilineTextAlignment(.center)
        .padding(.top, 288)
    }
    
    func formattedDateString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ZStack {
                    Image("backgroundImage") // 원형 배경
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                        .position(x: UIScreen.main.bounds.width/2, y: 119)
                    
                    VStack(spacing: 0) {
                        HomeNavigationBarView().padding(.top, 16)
                        UserInformationView().padding(.top, 8)
                        AnnouncementView().padding(.top, 8)
                        MainCalendarView(currentDate: self.$currentDate, shouldShowCalendarPopup: $shouldShowCalendarPopup).padding(.top, 8)
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
                    
                } // ZStack

            } // ScrollView
            .background(Color.background)
            
            Rectangle() // 팝업 뷰 뒤에 회색 배경
                .foregroundColor(.black)
                .opacity(shouldShowCalendarPopup ? 0.6 : 0)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        } // ZStack (최 상단에 팝업 뷰 배치)
        .popup(isPresented: $shouldShowCalendarPopup, view: {self.createPopup()},
               customize: {
            $0
                .type(.default)
                .position(.top)
                .animation(.bouncy)
                .closeOnTap(false)
                .closeOnTapOutside(true)
        })

    }
}


func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    
    return calendar.isDate(date1, inSameDayAs: date2)
}


#Preview {
    HomeView()
}

// nextView(isClicked: $isClicked)
