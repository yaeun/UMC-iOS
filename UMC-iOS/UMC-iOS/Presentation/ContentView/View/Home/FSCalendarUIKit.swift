//
//  FSCalendarUIKit.swift
//  UMC-iOS
//
//  Created by 김승원 on 2024/01/18.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar: FSCalendar!
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar = FSCalendar(frame: CGRect(x: 0.0,
                                            y: 40.0,
                                            width: self.view.frame.width,
                                            height: 300.0))
        calendar.scrollDirection = .vertical            // 달력 넘기는 방식
        calendar.scope = .month

        // show
        self.view.addSubview(calendar)
        
        // 캘린더 폰트 사이즈
        // 헤더
        calendar.appearance.headerDateFormat = "MMMM"   // 헤더 표시 방식
        // calendar.appearance.headerDateFormat = "MMMM-yyyy"  // 이렇게 표시할지 말지
        
        calendar.appearance.headerTitleColor = .main2   // 헤더 색상
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        // 주
        calendar.appearance.weekdayTextColor = .calendar    // 요일 색상
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        
        // 일
        calendar.appearance.todayColor = .none          // 오늘 날짜 배경 색
        calendar.appearance.titleTodayColor = .main2    // 오늘 날짜 글자 색
        // 오늘 날짜 글자만 따로 폰트 조절이 안 된다..
        calendar.appearance.selectionColor = .main2  // 선택된 날짜 배경 색
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        
        calendar.dataSource = self
        calendar.delegate = self
        
        // 여러 날짜 선택 가능
        calendar.allowsMultipleSelection = true
        
    }
    
    //MARK: - Datasource
    // 지난 날은 활성화 X
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    // 여기 날짜별 이벤트
    /*
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        formatter.dateFormat = "dd-MM-yyyy"
        guard let eventDate = formatter.date(from: "25-01-2024") else { return 0 }
        if date.compare(eventDate) == .orderedSame {
            return 2      // 이벤트 개수
        }
        return 0
    }
     */
    
    // 오늘 기준 7일 뒤까지만 활성화
    /*
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24*60*60)*6)
    }
     */
    
    //MARK: - Delegate
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("날짜 선택 == \(formatter.string(from: date))")
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("날짜 선택 해제 == \(formatter.string(from: date))")
    }
}







#if DEBUG
import SwiftUI

struct ViewControllerPresenterable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
}

struct ViewControllerPresenterable_PreviewProvider : PreviewProvider {
    static var previews: some View {
        ViewControllerPresenterable()
    }
}
#endif

