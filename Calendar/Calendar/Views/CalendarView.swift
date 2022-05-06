//
//  Calendar.swift
//  Calendar
//
//  Created by Edward Han on 2022-05-03.
//

import SwiftUI

struct CalendarView: View {
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter

    @ObservedObject var calendarManager: CalendarManager
    
    init(calendarManager: CalendarManager) {
        self.calendar = calendarManager.calendar
        self.monthFormatter = DateFormatter(dateFormat: "MMMM", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        self.fullFormatter = DateFormatter(dateFormat: "MMMM dd, yyyy", calendar: calendar)
        self.calendarManager = calendarManager
        print(calendarManager.highlightDate)
    }

    var body: some View {
        VStack {
            MonthView(
                calendar: calendar,
                date: $calendarManager.selectedDate,
                content: { date in
                    Button(action: { calendarManager.selectedDate = date }) {
                        Text("00")
                            .padding(8)
                            .foregroundColor(.clear)
                            .background(
                                calendar.isDate(date, inSameDayAs: calendarManager.selectedDate) ? .blue
                                : calendarManager.highlightDate.contains(date) ? .gray
                                    : .clear
                            )
                            .cornerRadius(8)
                            .accessibilityHidden(true)
                            .overlay(
                                Text(dayFormatter.string(from: date))
                                    .foregroundColor(
                                        (calendar.isDate(date, inSameDayAs: calendarManager.selectedDate) || calendarManager.highlightDate.contains(date)) ? .white
                                        : .black
                                    )
                            )
                    }
                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        .foregroundColor(.secondary)
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date))
                },
                title: { date in
                    HStack {
                        Text(monthFormatter.string(from: date))
                            .font(.headline)
                            .padding()
                        Spacer()
                        Button {
                            guard let newDate = calendar.date(
                                byAdding: .month,
                                value: -1,
                                to: calendarManager.selectedDate
                            ) else {
                                return
                            }

                            calendarManager.selectedDate = newDate
                        } label: {
                            Label(
                                title: { Text("Previous") },
                                icon: { Image(systemName: "chevron.left") }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity)
                        }
                        Button {
                            guard let newDate = calendar.date(
                                byAdding: .month,
                                value: 1,
                                to: calendarManager.selectedDate
                            ) else {
                                return
                            }

                            calendarManager.selectedDate = newDate
                        } label: {
                            Label(
                                title: { Text("Next") },
                                icon: { Image(systemName: "chevron.right") }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity)
                        }
                    }
                    .padding(.bottom, 6)
                }
            )
            .equatable()
        }
        .padding()
    }
}

// MARK: - Previews

#if DEBUG
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            CalendarView(calendarManager: CalendarManager(calendar: Calendar(identifier: .gregorian)))
//            CalendarView(calendarManager: CalendarManager(calendar: Calendar(identifier: .islamicUmmAlQura)))
//            CalendarView(calendarManager: CalendarManager(calendar: Calendar(identifier: .hebrew)))
//            CalendarView(calendarManager: CalendarManager(calendar: Calendar(identifier: .indian)))
        }
    }
}
#endif
