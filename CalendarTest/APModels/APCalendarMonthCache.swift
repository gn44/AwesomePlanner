//
//  APCalendarMonthCache.swift
//  CalendarTest
//
//  Created by Gints Osis on 22/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarMonthCache: NSObject {

    // format Year:[Month:APCalendarMonth]
    private var cache:[String:[String:APCalendarMonth]] = [:]
    
    public func cachedOrNewMonthWithComponents(components:DateComponents) -> APCalendarMonth {
        let year = components.year!
        let month = components.month!
        
        guard let yearDict:Dictionary = self.cache[String(year)] else
        {
            let aPMonth = self.newCachedAPMonthWithComponents(components: components)
            return aPMonth
        }
        
        guard let cachedMonth:APCalendarMonth = yearDict[String(month)] else
        {
            let aPMonth = self.newCachedAPMonthWithComponents(components: components)
            return aPMonth
        }
        
        return cachedMonth
        
    }
    
    private func newCachedAPMonthWithComponents(components:DateComponents) -> APCalendarMonth {
        
        let year = components.year!
        let month = components.month!
        
        // theres no cached year, create one with this instance
        guard var yearDict:Dictionary = self.cache[String(year)] else
        {
            let aPMonth = APCalendarMonth.init(components: components)
            cache[String(year)] = [String(month):aPMonth]
            return aPMonth
        }
        
        
        // if theres no month yet create new instance for month
        guard let cachedMonth:APCalendarMonth = yearDict[String(month)] else
        {
            let aPMonth = APCalendarMonth.init(components: components)
            self.cache[String(year)]![String(month)] = aPMonth
            return aPMonth
        }
        
        return cachedMonth
        
        
    }
}
