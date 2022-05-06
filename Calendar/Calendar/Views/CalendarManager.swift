//
//  CalendarManager.swift
//  Calendar
//
//  Created by Edward Han on 2022-05-04.
//

import Foundation

final class CalendarManager: ObservableObject {

    @Published var selectedDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())! {
        didSet {
            onSelectedDateChange()
        }
    }
    @Published var highlightDate: Set<Date>
    
    //private static var now = Date() // Cache now
    public let calendar: Calendar

    init(calendar: Calendar) {
        self.calendar = calendar
        self.highlightDate = Set()
    }
    
    init(calendar: Calendar, highlightDate: Set<Date>) {
        self.calendar = calendar
        self.highlightDate = highlightDate
    }
    
    func onSelectedDateChange() {
        // Do something when the user changes the selected Date
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate)!
        
        highlightDate.insert(futureDate)
    }
    
    public func insertHighlightDate(date: Date) {
        highlightDate.insert(date)
    }
    
    public func removeHighlightDate(date: Date) {
        highlightDate.remove(date)
    }
}
