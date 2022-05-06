//
//  CalendarApp.swift
//  Calendar
//
//  Created by Edward Han on 2022-05-03.
//

import SwiftUI

@main
struct CalendarApp: App {
    // Calendar Manager acts as the main view model of the calendar component
    @ObservedObject var calendarManager: CalendarManager
    
    init() {
        
        var dateComponent = DateComponents()
        dateComponent.day = 2
        var futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())!
        futureDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: futureDate)!
        
        var set = Set<Date>()
        set.insert(futureDate)
                
        calendarManager = CalendarManager(calendar: Calendar(identifier: .gregorian), highlightDate: set)
    }
    
    var body: some Scene {
        WindowGroup {
            // Formatting and rendering for the entire file
            Text("Selected date: \(calendarManager.selectedDate)")
                .bold()
                .foregroundColor(.blue)

            CalendarView(calendarManager: calendarManager)
        }
    }
}
