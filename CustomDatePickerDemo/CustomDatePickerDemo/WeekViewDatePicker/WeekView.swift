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
                ForEach(extractDateWeek(currentMonth)) { value in
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
                .font(.title3.bold())
                .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
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

struct WeekView_Previews: PreviewProvider {
    @State static var currentDate = Date()
    
    static var previews: some View {
        WeekView(currentDate: $currentDate)
    }
}
