//
//  APCalendarScrollView.swift
//  CalendarTest
//
//  Created by Gints Osis on 18/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

protocol APCalendarScrollViewDelegate: class {
    
    func calendarScrollViewDidChangeLayout(apCalenderScollView:APCalendarScrollView)
}

class APCalendarScrollView: UIScrollView,UIScrollViewDelegate {

    @IBOutlet weak var view3Leading: NSLayoutConstraint!
    @IBOutlet weak var view2Leading: NSLayoutConstraint!
    @IBOutlet weak var view1Leading: NSLayoutConstraint!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var apCalendarView3: APCalendarView!
    @IBOutlet weak var apCalendarView2: APCalendarView!
    @IBOutlet weak var apCalendarView1: APCalendarView!
    
    var superView:UIView!
    
    weak var calenderScrollViewDelegate: APCalendarScrollViewDelegate?
    
    let aPCalendarMonthCache:APCalendarMonthCache = APCalendarMonthCache.init()
    
    
    public var currentCenteredDateComponents:DateComponents!
    
    
    private var currentSelectedAPMonth:APCalendarMonth!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        superView = self.superview
        self.delegate = self
    }
    
    
    // MARK: Public
    public func centerSecondElement()  -> Void {
        
        view2Leading.constant = self.superView.frame.size.width
        view3Leading.constant = self.superView.frame.size.width * 2
        
        calenderScrollViewDelegate?.calendarScrollViewDidChangeLayout(apCalenderScollView: self)
        
        
        self.currentCenteredDateComponents = aPComponents
        self.updateCalendarMonths(left: apCalendarView1, center: apCalendarView2, right: apCalendarView3)
    }
    
    public func setContentSize() -> Void {
        self.contentSize = CGSize(width: self.superView.frame.size.width * 3, height: 300)
        
        self.contentOffset = CGPoint(x: self.superView.frame.size.width, y: 0)
    }
    
    // MARK: APCalendarMonth updating
    
    func updateCalendarMonths(left:APCalendarView,center:APCalendarView,right:APCalendarView) -> Void {
        
        var components = self.currentCenteredDateComponents!
        let currentMonth = self.aPCalendarMonthCache.cachedOrNewMonthWithComponents(components: components)
        center.updateCalendarViewWithMonth(apMonth: currentMonth)
        
        components.month = components.month! - 1
        let previousMonth = self.aPCalendarMonthCache.cachedOrNewMonthWithComponents(components: components)
        left.updateCalendarViewWithMonth(apMonth: previousMonth)
        
        components.month = components.month! + 2
        
        let nextMonth = self.aPCalendarMonthCache.cachedOrNewMonthWithComponents(components: components)
        
        right.updateCalendarViewWithMonth(apMonth: nextMonth)
    }

    
    //MARK: Scrollview handling
    func updatePositionsWithScrollView(scrollView:UIScrollView) -> Void {
        
        let rect1 = scrollView.convert(view1.frame, to: self.superView)
        let rect2 = scrollView.convert(view2.frame, to: self.superView)
        let rect3 = scrollView.convert(view3.frame, to: self.superView)
        
        let smallest = min(min(abs(rect1.origin.x), abs(rect2.origin.x)),abs(rect3.origin.x))
        
        // detect current centered element
        
        var center:APCalendarView!
        var left:APCalendarView!
        var right:APCalendarView!
        if abs(rect1.origin.x) == smallest
        {
            // we are looking at first view
            
            view3Leading.constant = 0
            view1Leading.constant = self.superView.frame.size.width
            view2Leading.constant = self.superView.frame.size.width * 2
            
            center = apCalendarView1
            left = apCalendarView3
            right = apCalendarView2
        } else if abs(rect2.origin.x) == smallest
        {
            // we are looking at second view
            
            view3Leading.constant = self.superView.frame.size.width * 2
            view1Leading.constant = 0
            view2Leading.constant = self.superView.frame.size.width
            
            center = apCalendarView2
            left = apCalendarView1
            right = apCalendarView3
        } else if abs(rect3.origin.x) == smallest
        {
            // we are looking at third view
            
            view3Leading.constant = self.superView.frame.size.width
            view1Leading.constant = self.superView.frame.size.width * 2
            view2Leading.constant = 0
            
            center = apCalendarView3
            left = apCalendarView2
            right = apCalendarView1
        } else {
            NSLog("nothing", "")
        }
        
        if scrollView.contentOffset.x == self.frame.size.width {
            // we didn't move at all
            return;
        } else if scrollView.contentOffset.x < self.frame.size.width {
            
            // we scrolled to the left
            self.currentCenteredDateComponents.month = self.currentCenteredDateComponents.month! - 1
        } else if scrollView.contentOffset.x > self.frame.size.width {
            
            // we scrolled to the right
            self.currentCenteredDateComponents.month = self.currentCenteredDateComponents.month! + 1
        }
        
        scrollView.contentOffset = CGPoint(x: self.superView.frame.size.width, y: 0)
        
        calenderScrollViewDelegate?.calendarScrollViewDidChangeLayout(apCalenderScollView: self)
        
        self.updateCalendarMonths(left: left, center: center, right: right)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if scrollView.isDecelerating {
            self.updatePositionsWithScrollView(scrollView: scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.updatePositionsWithScrollView(scrollView: scrollView)
    }
    
}
