//
//  MainCalendarView.swift
//  UMC-iOS
//
//  Created by 김승원 on 2024/01/18.
//

import SwiftUI
import UIKit
import FSCalendar

struct MainCalendarView: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0 // 화살표 버튼 클릭시 월 업데이트
   
    
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let colums = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .frame(height: 260)
                .padding(.horizontal, 18)
                .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 2)
            
            VStack(spacing: 4) {
                HStack(spacing: 10) { // 월, 버튼
                    VStack(alignment: .leading, spacing: 0) {
                        Text(extraDate()[0])
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.main2)
                    } // VStack
                    
                    Spacer(minLength: 0)
                    
                    Button { // 왼쪽 버튼, 이전 달
                        print("CalendarLeftBtn Tapped")
                        print("\(extraDate()[1])")
                        withAnimation {
                            currentMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color.main2)
                    } // Button
                    
                    Button { // 오른쪽 버튼, 다음 달
                        print("CalendarRightBtn Tapped")
                        withAnimation {
                            currentMonth += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color.main2)
                    } // Button
                    
                } // HStack
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
                
                // Day View 주
                HStack(spacing: 0) {
                    ForEach(days, id: \.self){day in
                        Text(day)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.calendar)
                            .fontWeight(.regular)
                            .frame(maxWidth: .infinity)
                    } // ForEach
                } // HStack
                .padding(.horizontal, 5)
                .padding(.bottom, 10)
                
                // 일 31개
                LazyVGrid(columns: colums, spacing: 12) {
                    ForEach(extractDate()) { value in
                        
                        CardView(value: value)
                    }
                }
                .padding(.horizontal, 9)
                
                Spacer()
            } // VStack
            .padding(.horizontal, 20)
            .padding(.top, 18)
            
        } // ZStack
        // 달 업데이트
        .onChange(of: currentMonth) {
            currentDate = getCurrentMonth()
        }
    }
    
    // 일 31개 ViewBuilder
    @ViewBuilder func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.calendar)
                    .fontWeight(.regular)
            }
        } // VStack
        .frame(height: 18, alignment: .top)
    }
    
    // 화면에 나타내기 위해 년도와 월 추가
    func extraDate() -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"  // 년도와 월
        
        let date = formatter.string(from: getCurrentMonth())
        
        return date.components(separatedBy: " ") // extraDate[0] == 년도, [1] == 월
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // 현재 월, 날 가져오기
        guard let currentMonth = calendar.date(byAdding: .month,
                                               value: self.currentMonth,
                                               to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue]{
        let calendar = Calendar.current
        
        // 현재 월, 날 가져오기
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            // 일 받아오기
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
}


extension Date {
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // 시작 날짜 받기
        let startDate = calendar.date(from: Calendar.current.dateComponents(
            [.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // date 받기
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
            
        }
    }
}


/*
// Model 아직 나누지 않음
// 날짜 칸 표시를 위한 일자 정보
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var isNotCurrentMonth: Bool
}

// 일정 정보
struct Schedule: Decodable {
    var name: String
    var startDate: Date
    var endDate: Date
    
    // 일정 표시 색 지정 (랜덤으로 지정)
    var color = Color(red: Double.random(in: 0.0...1.0),
                      green: Double.random(in: 0.0...1.0),
                      blue: Double.random(in: 0.0...1.0))
    
    enum CodingKeys: String, CodingKey {
        case name, startDate, endDate
    }
}

extension Date {
    // 년도
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    // 월
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    // 일
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // 요일
    public var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    // 이 날짜가 포함된 월의 모든 일자의 Date
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // 시작 날짜 받아오기
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in:.month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    // 이 날짜가 포함된 월의 마지막 일
    func getLastDayInMonth() -> Int {
        let calendar = Calendar.current
        
        return (calendar.range(of: .day, in: .month, for: self)?.endIndex ?? 0) - 1
    }
    
    // 이 날짜가 포함된 월의 첫 일
    func getFirstDayInMonth() -> Int {
        let calendar = Calendar.current
        
        return (calendar.range(of: .day, in: .month, for: self)?.startIndex ?? 0)
    }
    
    // 시간 값을 제외한 Date 리턴
    func withOutTime() -> Date {
        let dateComponents = DateComponents(year: self.year, month: self.month, day: self.day)
        
        return Calendar.current.date(from: dateComponents) ?? self
    }
}

extension Color {
    // 배경색에 따라 텍스트 색을 검을색 또는 흰색으로 설정
    var textColor: Color {
        let uiColor = UIColor(self)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // 0 to 1 scale이므로 255 곱하기
        let value = ( (red*255*299) + (green*255*587) + (blue*255*114) ) / 1000
        
        return value >= 125 ? .black : .white
    }
}
 
 */
 
#Preview {
    HomeView()
}
