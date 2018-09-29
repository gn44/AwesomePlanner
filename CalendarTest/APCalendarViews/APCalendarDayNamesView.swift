//
//  APCalendarDayNamesView.swift
//  CalendarTest
//
//  Created by Gints Osis on 29/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarDayNamesView: UIView {

    @IBOutlet var mondayView: APCalendarDayNameView!
    @IBOutlet var tuesdayView: APCalendarDayNameView!
    @IBOutlet var wednesdayView: APCalendarDayNameView!
    @IBOutlet var thursdayView: APCalendarDayNameView!
    @IBOutlet var fridayView: APCalendarDayNameView!
    @IBOutlet var saturdayView: APCalendarDayNameView!
    @IBOutlet var sundayView: APCalendarDayNameView!
    
    var aPCalenderDayNameViews: [APCalendarDayNameView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aPCalenderDayNameViews = [mondayView,tuesdayView,wednesdayView,thursdayView,fridayView,saturdayView,sundayView]
        
        for calendarDayNameView in aPCalenderDayNameViews {
            calendarDayNameView.dayLabel.font = UIFont.systemFont(ofSize: 13)
            calendarDayNameView.dayLabel.textColor = UIColor.lightGray
        }
    }

}
