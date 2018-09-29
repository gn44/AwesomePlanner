//
//  APEndlessScrollView.swift
//  CalendarTest
//
//  Created by Gints Osis on 18/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

enum APEndlessScrollViewDirection:Int
{
    case none = 0
    case left
    case right
}

class APEndlessScrollView: UIScrollView,UIScrollViewDelegate {
    
    @IBOutlet weak var view3Leading: NSLayoutConstraint!
    @IBOutlet weak var view2Leading: NSLayoutConstraint!
    @IBOutlet weak var view1Leading: NSLayoutConstraint!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    var superView:UIView!
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        superView = self.superview
        self.delegate = self
    }
    
    
    // MARK: Public
    public func centerSecondElement()  -> Void {
        
        self.contentOffset = CGPoint(x: self.superView.frame.size.width, y: 0)
    }
    
    //MARK: Scrollview handling
    func updatePositionsWithScrollView(scrollView:UIScrollView) -> Void {
        
        let rect1 = scrollView.convert(view1.frame, to: self.superView)
        let rect2 = scrollView.convert(view2.frame, to: self.superView)
        let rect3 = scrollView.convert(view3.frame, to: self.superView)
        
        let smallest = min(min(abs(rect1.origin.x), abs(rect2.origin.x)),abs(rect3.origin.x))
        
        // detect current centered element
        
        var center:UIView!
        var left:UIView!
        var right:UIView!
        if abs(rect1.origin.x) == smallest
        {
            // we are looking at first view
            
            view3Leading.constant = 0
            view1Leading.constant = self.superView.frame.size.width
            view2Leading.constant = self.superView.frame.size.width * 2
            
            center = view1
            left = view3
            right = view2
        } else if abs(rect2.origin.x) == smallest
        {
            // we are looking at second view
            
            view3Leading.constant = self.superView.frame.size.width * 2
            view1Leading.constant = 0
            view2Leading.constant = self.superView.frame.size.width
            
            center = view2
            left = view1
            right = view3
        } else if abs(rect3.origin.x) == smallest
        {
            // we are looking at third view
            
            view3Leading.constant = self.superView.frame.size.width
            view1Leading.constant = self.superView.frame.size.width * 2
            view2Leading.constant = 0
            
            center = view3
            left = view2
            right = view1
        } else {
            NSLog("nothing", "")
        }
        
        var direction:APEndlessScrollViewDirection = .none
        
        if scrollView.contentOffset.x == self.frame.size.width {
            // we didn't move at all
            return;
            
        } else if scrollView.contentOffset.x < self.frame.size.width {
            
            // we scrolled to the left
            direction = .left
        } else if scrollView.contentOffset.x > self.frame.size.width {
            
            // we scrolled to the right
            direction = .right
        }
        
        scrollView.contentOffset = CGPoint(x: self.superView.frame.size.width, y: 0)
        
        
        self.scrollViewShouldUpdateViews(left: left, center: center, right: right, direction: direction)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if scrollView.isDecelerating {
            self.updatePositionsWithScrollView(scrollView: scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.updatePositionsWithScrollView(scrollView: scrollView)
    }
    
    // MARK: Abstract for subclass
    
    func scrollViewShouldUpdateViews(left:UIView, center:UIView, right:UIView, direction:APEndlessScrollViewDirection)
    {
        preconditionFailure("This method must be overridden")
    }
    
}
