//
//  WeekView.swift
//  CustomDatePickerDemo
//
//  Created by Noronha, Ronald on 29/5/2023.
//

import SwiftUI

struct WeekView: View {
    
    let date = Date()
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack {
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("Pink"))
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            Text("\(value.date.formatted(Date.FormatStyle().weekday(.abbreviated)))")
            if let task = tasks.first(where: { task in
                return isSameDay(date1: task.taskDate, date2: value.date)
            }) {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)

                Spacer()

                Circle()
                    .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Pink") )
                    .frame(width: 8, height: 8)

            } else {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)

                Spacer()
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        // Getting Current month date
        let currentMonth = getCurrentMonth()
        
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
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting Current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
}

struct WeekView_Previews: PreviewProvider {
    @State static var currentDate = Date()
    
    static var previews: some View {
        WeekView(currentDate: $currentDate)
    }
}

extension Date {
    func getAllDatesInWeek() -> [Date] {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: self)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: self)!
        return (weekdays.lowerBound..<weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: self)}
    }
}
