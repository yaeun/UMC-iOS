//
//  CalendarTask.swift
//  UMC-iOS
//
//  Created by 김승원 on 2024/01/19.
//

import SwiftUI

// Task 배열
struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String // 일정 제목
    var time: Date = Date() // 일단 현재 날짜
    var mainText: String // 일정 본문
    var writer: String // 작성자
}

// Total Task Meta View
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task] // 하루에 일정이 겹칠수도 있기 때문에 배열로 선언
    var taskDate: Date // 일정 날짜
}

// 임시 일정 데이터
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

// 임시 일정
/*
var tasks: [TaskMetaData] = [

    TaskMetaData(task: [Task(title: "Talk to kJustine"), Task(title: "iPhone 13 Great Design Change"), Task(title: "Nothing Much Workout !!!")],
                 taskDate: getSampleDate(offset: 3)),
    
    TaskMetaData(task: [
        Task(title: "이게 뭔지 모르겠어"),
        Task(title: "캘린더 너무 어렵다"),
        ], taskDate: getSampleDate(offset:-8))

]
*/

// 임시 일정

var tasks: [TaskMetaData] = [
    TaskMetaData(task: [Task(title: "[연합] 데모데이 신청 마감",
                             mainText: "데모데이 신청 마감일 입니다.\n잊지말고 신청해 주세요~🥳",
                             writer: "우디")],
                 taskDate: getSampleDate(offset: 3)
                )
]

/*

// 임시 일정 ...
var tasks: [Task] = [Task(title: "[교내] 연합 회식 개최",
                         time: Date(),
                         mainText: "안녕하세요 여러분 벡스입니다~!!!\n드디어 회식을 개최하게 되었는데요!!!\n많은 참여 부탁드립니다!",
                         location: "수꼬치 인하대 후문점",
                         taskDate: getSampleDate(offset: 3))
]
*/
