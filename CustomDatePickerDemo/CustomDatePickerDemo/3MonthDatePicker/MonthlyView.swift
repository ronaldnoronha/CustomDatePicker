//
//  MontlyView.swift
//  CustomDatePickerDemo
//
//  Created by Ronald Noronha on 21/6/2023.
//

import SwiftUI

struct MonthlyView: View {
    let date = Date()
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        VStack {
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(days, id:\.self) { day in
                    WeekdayView(value: day)
                }
            }
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDateMonth(currentMonth)) { value in
                    if value.day != -1 {
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
                        
                    } else {
                        BlankCardView()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func WeekdayView(value: String) -> some View {
        Text(value)
            .font(.title3.bold())
            .foregroundColor(.primary)
    }
    
    @ViewBuilder
    func BlankCardView() -> some View {
        VStack{}
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
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
}


struct MonthlyView_Previews: PreviewProvider {
    @State static var currentDate = Date()
    
    static var previews: some View {
        MonthlyView(currentDate: $currentDate)
    }
}
