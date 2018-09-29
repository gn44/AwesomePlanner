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
    
    var aPCalendarSelectedView:APCalendarDayView!
    
    
    // long press handling of selection
    var longPressedDays = Set<APCalendarDayView>()
    var longPressFirstDayView:APCalendarDayView!
    var previousLongPressEndIndex:Int = 0
    var previousLongPressStartIndex:Int = 0
    let longPressGestureRecognizer:UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    
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
        
        self.longPressGestureRecognizer.minimumPressDuration = 0.1
        self.longPressGestureRecognizer.addTarget(self, action: #selector(longPressed))
        self.addGestureRecognizer(self.longPressGestureRecognizer)
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
            self.removeSelectionIfNeeded(apCalendarDayView: apCalendarView)
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
    }
    
    func removeSelectionIfNeeded(apCalendarDayView:APCalendarDayView) -> Void {
        if apCalendarDayView.isSelected {
            apCalendarDayView.removeSelection(animated: false)
        }
    }
    
    
    //MARK: Long press and drag
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        if sender.state == .began || sender.state == .changed {
            let point:CGPoint = sender.location(in: self)
            

            guard let selectedDayView = self.dayViewAtPosition(point: point) else
            {
                return
            }
            
            if sender.state == .began {
                guard selectedDayView.dayStatus == .current else {
                    return
                }
                
                if self.aPCalendarSelectedView != nil {
                    self.aPCalendarSelectedView!.removeSelection(animated: true)
                }
                
                self.longPressFirstDayView = selectedDayView
                selectedDayView.addToMultiSelection()
            } else if sender.state == .changed {
                
                if self.longPressFirstDayView == nil {
                    guard selectedDayView.dayStatus == .current else {
                        return
                    }
                    self.longPressFirstDayView = selectedDayView
                }
                
                if self.longPressFirstDayView != selectedDayView {
                    
                    self.longPressSelectionChangedWithEndingDayView(apCalendarDayView: selectedDayView)
                }
            }
            
        } else {
            self.clearLongPressSelection()
        }
    }
    
    func longPressSelectionChangedWithEndingDayView(apCalendarDayView:APCalendarDayView) -> Void {
        
        guard apCalendarDayView.dayStatus == .current else
        {
            self.clearLongPressSelection()
            return
        }
        
        let displayedDate = apCalendarDayView.currentDateComponents.day!
        
        let startIndex:Int = self.longPressFirstDayView.currentDateComponents.day! + self.aPCalendarMonth.startWeekDay - 1
        let endIndex:Int = displayedDate + self.aPCalendarMonth.startWeekDay - 1
        
        // fill all indexes from largest to smallest
        let largestIndex = max(endIndex, startIndex) - 1
        let smallestIndex = min(endIndex, startIndex) - 1
        
        self.previousLongPressStartIndex = startIndex
        
        guard self.previousLongPressEndIndex != largestIndex  else {
            return
        }
        
        guard self.previousLongPressStartIndex != endIndex  else {
            return
        }
        
        if largestIndex < self.previousLongPressStartIndex {
            self.clearLongPressSelection()
            
            self.longPressGestureRecognizer.isEnabled = false
            self.longPressGestureRecognizer.isEnabled = true
            return
        }
        
        // if previous index is smaller it means we have added days to selection
        if self.previousLongPressEndIndex < largestIndex {
            for i:Int in smallestIndex...largestIndex
            {
                let calendarDayView:APCalendarDayView = aPCalenderDayViews[i]
                calendarDayView.addToMultiSelection()
            }
        } else
        {
            // if previous index is larger we have removed from selection
            for i:Int in largestIndex + 1...self.previousLongPressEndIndex
            {
                let calendarDayView:APCalendarDayView = aPCalenderDayViews[i]
                calendarDayView.removeFromMultiSelection()
            }
        }
        self.previousLongPressEndIndex = largestIndex
        
    }
    
    func clearLongPressSelection() -> Void {
        
        guard self.longPressFirstDayView != nil else {
            return
        }
        if self.previousLongPressStartIndex == 0 || self.previousLongPressEndIndex == 0 {
            NSLog("no movement was made after long pressing, remove longPressFirstDayView from selection", "")
            self.longPressFirstDayView.removeFromMultiSelection()
        } else {
        
            for i:Int in self.previousLongPressStartIndex - 1...self.previousLongPressEndIndex
            {
                let calendarDayView:APCalendarDayView = aPCalenderDayViews[i]
                calendarDayView.removeFromMultiSelection()
            }
        }
        
        self.previousLongPressStartIndex = 0
        self.previousLongPressEndIndex = 0
        self.longPressFirstDayView = nil
    }
    
    func dayViewAtPosition(point:CGPoint) -> APCalendarDayView? {
        let dayWidth = apCalendarDayView1.frame.width
        let dayHeight = apCalendarDayView1.frame.height
        
        let verticalIndex:Int = Int(point.y / dayHeight)
        let horizontalIndex:Int = Int(point.x / dayWidth)
        
        let index:Int = Int(verticalIndex * 7 + horizontalIndex)
        
        let closestCalendarDayView = aPCalenderDayViews[index]
        
        let selfFrame = closestCalendarDayView.convert(closestCalendarDayView.frame, to: self)
        
        let selfPoint = CGPoint(x: closestCalendarDayView.frame.origin.x, y: selfFrame.origin.y)
        
        if point.distance(toPoint: selfPoint) / 2 < closestCalendarDayView.frame.size.width {
            return aPCalenderDayViews[index]
        } else {
            return nil
        }
        
    }
}

extension APCalendarView:APCalendarDayViewDelegate
{
    func dayButtonTapped(dayView: APCalendarDayView) {
        
        if self.aPCalendarSelectedView != nil {
            self.aPCalendarSelectedView.removeSelection(animated: true)
        }
        
        self.aPCalendarSelectedView = dayView
    }
    
}

extension CGPoint {
    
    func distance(toPoint p:CGPoint) -> CGFloat {
        return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2))
    }
}
