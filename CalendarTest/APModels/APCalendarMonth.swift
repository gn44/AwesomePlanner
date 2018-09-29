//
//  APCalendarMonth.swift
//  CalendarTest
//
//  Created by Gints Osis on 19/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarMonth: NSObject {

    init(components:DateComponents)
    {
        super.init()
        self.components = components
        self.calculateProperties()
    }
    
    func calculateProperties() -> Void {
        
        let unitFlags = Set<Calendar.Component>([.month, .year, .day])
        
        let date = apCalendar.date(from: self.components)
        
        let components = apCalendar.dateComponents(unitFlags, from: date!)
        
        let month = String(components.month!)
        let year = String(components.year!)
        let firstOfMonth = APCalendarUtilities.shared().firstDayDateFormatter.date(from: "01-" + month + "-" + year)
        
        
        self.startWeekDay = apCalendar.component(.weekday, from: firstOfMonth!)
        
        let lastOfPreviousMonth = apCalendar .date(byAdding: .day, value: -1, to: firstOfMonth!, wrappingComponents: false)
        
        let lastMonthsComponents = apCalendar.dateComponents(unitFlags, from: lastOfPreviousMonth!)
        
        self.lastMonthDayCount = lastMonthsComponents.day!
        
        let range = apCalendar.range(of: .day, in: .month, for: date!)!
        self.dayCount = range.count
        
    }
    
    private (set) var startWeekDay:Int = 0
    private (set) var dayCount:Int = 0
    private (set) var lastMonthDayCount:Int = 0
    
    private (set) var components:DateComponents!
}
