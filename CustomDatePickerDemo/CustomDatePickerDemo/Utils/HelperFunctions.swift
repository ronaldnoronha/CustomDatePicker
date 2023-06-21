//
//  HelperFunctions.swift
//  CustomDatePickerDemo
//
//  Created by Ronald Noronha on 21/6/2023.
//

import Foundation

func isSameDay(date1: Date, date2: Date) -> Bool {
    return Calendar.current.isDate(date1, inSameDayAs: date2)
}

func extractDateWeek(_ currentMonth: Int) -> [DateValue] {
    let calendar = Calendar.current
    // Getting Current month date
    let currentMonth = getCurrentMonth(currentMonth: currentMonth)
    
    var days = currentMonth.getAllDatesInWeek().compactMap { date -> DateValue in
        let day = calendar.component(.day, from: date)
        let dateValue =  DateValue(day: day, date: date)
        return dateValue
    }
    
    // adding offset days to get exact week day...
    let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekday - 1 {
        days.insert(DateValue(day: -1, date: Date()), at: 0)
    }
    
    return days
}

func extractDateMonth(_ currentMonth: Int) -> [DateValue] {
    let calendar = Calendar.current
    // Getting Current month date
    let currentMonth = getCurrentMonth(currentMonth: currentMonth)
    
    var days = currentMonth.getAllDatesInAMonth().compactMap { date -> DateValue in
        let day = calendar.component(.day, from: date)
        let dateValue =  DateValue(day: day, date: date)
        return dateValue
    }
    
    // adding offset days to get exact week day...
    let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekday - 1 {
        days.insert(DateValue(day: -1, date: Date()), at: 0)
    }
    
    return days
}

func getCurrentMonth(currentMonth: Int) -> Date {
    let calendar = Calendar.current
    
    // Getting Current month date
    guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
        return Date()
    }
    
    return currentMonth
}
