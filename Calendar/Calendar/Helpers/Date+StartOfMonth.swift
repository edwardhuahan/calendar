//
//  Date+StartOfMonth.swift
//  Calendar
//
//  Created by Edward Han on 2022-05-04.
//

import Foundation

extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}
