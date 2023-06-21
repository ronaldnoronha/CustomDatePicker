//
//  Date+extension.swift
//  CustomDatePickerDemo
//
//  Created by Ronald Noronha on 21/6/2023.
//

import Foundation

extension Date {
    func getAllDatesInWeek() -> [Date] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: self)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: self)!
        return (weekdays.lowerBound..<weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: self)}
    }
        
    func getAllDatesInAMonth() -> [Date] {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
        let monthRange = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!
        var dates: [Date] = []
        for day in monthRange {
            dates.append(calendar.date(byAdding: .day, value: day-1, to: firstDayOfMonth)!)
        }
        return dates
    }
}
