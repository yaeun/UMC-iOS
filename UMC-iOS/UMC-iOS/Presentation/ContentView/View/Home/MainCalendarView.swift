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
    var body: some View {
        Rectangle()
            .foregroundColor(Color.white)
            .cornerRadius(12)
            .frame(height: 190)
            .padding(.horizontal, 18)
            .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 2)
    }
}
