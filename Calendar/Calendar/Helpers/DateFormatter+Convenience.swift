//
//  DateFormatter.swift
//  Calendar
//
//  Created by Edward Han on 2022-05-04.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}
