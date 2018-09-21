//
//  APCalendarUtilities.swift
//  CalendarTest
//
//  Created by Gints Osis on 19/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarUtilities: NSObject {

    let firstDayDateFormatter:DateFormatter = DateFormatter.init()
    
    private static var sharedUtilities: APCalendarUtilities = {
        let utilities = APCalendarUtilities.init()
        
        utilities.firstDayDateFormatter.dateFormat = "01-MM-yyyy"
        utilities.firstDayDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        utilities.firstDayDateFormatter.calendar = apCalendar
        
        return utilities
    }()
    
    
    class func shared() -> APCalendarUtilities {
        return sharedUtilities
    }
}
