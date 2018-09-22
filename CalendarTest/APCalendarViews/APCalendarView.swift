//
//  APCalendarView.swift
//  CalendarTest
//
//  Created by Gints Osis on 18/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarView: UIView {
    
    @IBOutlet var apCalendarDayView1: APCalendarDayView!
    @IBOutlet var apCalendarDayView2: APCalendarDayView!
    @IBOutlet var apCalendarDayView3: APCalendarDayView!
    @IBOutlet var apCalendarDayView4: APCalendarDayView!
    @IBOutlet var apCalendarDayView5: APCalendarDayView!
    @IBOutlet var apCalendarDayView6: APCalendarDayView!
    @IBOutlet var apCalendarDayView7: APCalendarDayView!
    @IBOutlet var apCalendarDayView8: APCalendarDayView!
    @IBOutlet var apCalendarDayView9: APCalendarDayView!
    @IBOutlet var apCalendarDayView10: APCalendarDayView!
    @IBOutlet var apCalendarDayView11: APCalendarDayView!
    @IBOutlet var apCalendarDayView12: APCalendarDayView!
    @IBOutlet var apCalendarDayView13: APCalendarDayView!
    @IBOutlet var apCalendarDayView14: APCalendarDayView!
    @IBOutlet var apCalendarDayView15: APCalendarDayView!
    @IBOutlet var apCalendarDayView16: APCalendarDayView!
    @IBOutlet var apCalendarDayView17: APCalendarDayView!
    @IBOutlet var apCalendarDayView18: APCalendarDayView!
    @IBOutlet var apCalendarDayView19: APCalendarDayView!
    @IBOutlet var apCalendarDayView20: APCalendarDayView!
    @IBOutlet var apCalendarDayView21: APCalendarDayView!
    @IBOutlet var apCalendarDayView22: APCalendarDayView!
    @IBOutlet var apCalendarDayView23: APCalendarDayView!
    @IBOutlet var apCalendarDayView24: APCalendarDayView!
    @IBOutlet var apCalendarDayView25: APCalendarDayView!
    @IBOutlet var apCalendarDayView26: APCalendarDayView!
    @IBOutlet var apCalendarDayView27: APCalendarDayView!
    @IBOutlet var apCalendarDayView28: APCalendarDayView!
    @IBOutlet var apCalendarDayView29: APCalendarDayView!
    @IBOutlet var apCalendarDayView30: APCalendarDayView!
    @IBOutlet var apCalendarDayView31: APCalendarDayView!
    @IBOutlet var apCalendarDayView32: APCalendarDayView!
    @IBOutlet var apCalendarDayView33: APCalendarDayView!
    @IBOutlet var apCalendarDayView34: APCalendarDayView!
    @IBOutlet var apCalendarDayView35: APCalendarDayView!
    @IBOutlet var apCalendarDayView36: APCalendarDayView!
    @IBOutlet var apCalendarDayView37: APCalendarDayView!
    @IBOutlet var apCalendarDayView38: APCalendarDayView!
    @IBOutlet var apCalendarDayView39: APCalendarDayView!
    @IBOutlet var apCalendarDayView40: APCalendarDayView!
    @IBOutlet var apCalendarDayView41: APCalendarDayView!
    @IBOutlet var apCalendarDayView42: APCalendarDayView!
    
    
    var aPCalenderDayViews: [APCalendarDayView]!
    var aPCalendarMonth:APCalendarMonth!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aPCalenderDayViews = [apCalendarDayView1,
                              apCalendarDayView2,
                              apCalendarDayView3,
                              apCalendarDayView4,
                              apCalendarDayView5,
                              apCalendarDayView6,
                              apCalendarDayView7,
                              apCalendarDayView8,
                              apCalendarDayView9,
                              apCalendarDayView10,
                              apCalendarDayView11,
                              apCalendarDayView12,
                              apCalendarDayView13,
                              apCalendarDayView14,
                              apCalendarDayView15,
                              apCalendarDayView16,
                              apCalendarDayView17,
                              apCalendarDayView18,
                              apCalendarDayView19,
                              apCalendarDayView20,
                              apCalendarDayView21,
                              apCalendarDayView22,
                              apCalendarDayView23,
                              apCalendarDayView24,
                              apCalendarDayView25,
                              apCalendarDayView26,
                              apCalendarDayView27,
                              apCalendarDayView28,
                              apCalendarDayView29,
                              apCalendarDayView30,
                              apCalendarDayView31,
                              apCalendarDayView32,
                              apCalendarDayView33,
                              apCalendarDayView34,
                              apCalendarDayView35,
                              apCalendarDayView36,
                              apCalendarDayView37,
                              apCalendarDayView38,
                              apCalendarDayView39,
                              apCalendarDayView40,
                              apCalendarDayView41,
                              apCalendarDayView42,]
        
        for aPCalendarDayView in aPCalenderDayViews {
            aPCalendarDayView.delegate = self
        }
    }
    
    
    func updateCalendarViewWithMonth(apMonth:APCalendarMonth) -> Void {
        
        self.aPCalendarMonth = apMonth
        
        // set first of the month
        var components = apMonth.components
        components?.day = 0
        
        // color last months days is gray and set their numbers
        for i:Int in 0...apMonth.startWeekDay - 1
        {
            let apCalendarView = aPCalenderDayViews[i]
            apCalendarView.dayStatus = .previous
            apCalendarView.dayLabel.textColor = UIColor.lightGray
            apCalendarView.dayLabel.text = String(apMonth.lastMonthDayCount - apMonth.startWeekDay + i + 2)
        }
        
        // fill days with sequential numbers
        var dayNumber:Int = 1
        for i:Int in apMonth.startWeekDay - 1...apMonth.dayCount + apMonth.startWeekDay - 2
        {
            let apCalendarView = aPCalenderDayViews[i]
            apCalendarView.dayStatus = .current
            apCalendarView.dayLabel.textColor = UIColor.black
            apCalendarView.dayLabel.text = String(dayNumber)
            dayNumber += 1
            components!.day = components!.day! + 1
            apCalendarView.currentDateComponents = components
        }
        
        // fill the rest with the next month
        var nextMonthDayNumber = 1
        for i:Int in apMonth.dayCount + apMonth.startWeekDay - 1...aPCalenderDayViews.count - 1
        {
            let apCalendarView = aPCalenderDayViews[i]
            apCalendarView.dayStatus = .next
            apCalendarView.dayLabel.textColor = UIColor.lightGray
            apCalendarView.dayLabel.text = String(nextMonthDayNumber)
            nextMonthDayNumber += 1
        }
        
        if aPCalendarMonth.selectedDate != nil {
            
            let selectedDay = aPCalendarMonth.selectedDate.day! - 1
            
            // find index matching the selected day
            let apCalendarView = aPCalenderDayViews[selectedDay + apMonth.startWeekDay - 1]
            apCalendarView.makeSelected()
            
        }
    }
}

extension APCalendarView:APCalendarDayViewDelegate
{
    func dayButtonTapped(dayView: APCalendarDayView) {
        
        // assign selected date to model
        // next time the model is used, set the selected date
        self.aPCalendarMonth.selectedDate = dayView.currentDateComponents
        
        NotificationCenter.default.post(name: kSelectedDateChanged, object: self, userInfo: [kCalendarViewKey:dayView,kCalendarMonthViewKey:self.aPCalendarMonth])
    }
    
}
