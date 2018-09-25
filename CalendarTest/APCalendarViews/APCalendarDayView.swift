//
//  APCalendarDayView.swift
//  CalendarTest
//
//  Created by Gints Osis on 18/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

enum APCalendarDayStatus:Int
{
    case previous = 0
    case current
    case next
}

protocol APCalendarDayViewDelegate: class {
    
    func dayButtonTapped(dayView:APCalendarDayView)
}

class APCalendarDayView: UIView {
    
    weak var delegate: APCalendarDayViewDelegate?
    
    var dayStatus:APCalendarDayStatus = .current
    
    var currentDateComponents:DateComponents!
    
    public var isSelected:Bool! = false

    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dayButton.addTarget(self, action: #selector(self.dayButtonTap), for: .touchUpInside)
    }
    
    @objc func dayButtonTap(){
        
        guard isSelected != true else {
            return
        }
        
        delegate?.dayButtonTapped(dayView: self)
        if dayStatus == .current {
            self.makeSelected(animated: true)
        }
    }
    
    func makeSelected(animated:Bool) -> Void {
        
        guard isSelected == false else {
            return
        }
        
        isSelected = true
        
        self.dayLabel.font = UIFont.boldSystemFont(ofSize: self.dayLabel.font.pointSize * 2)
        self.dayLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        self.backgroundColor = UIColor.lightGray
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.addDaySelection()
            });
        } else {
            self.addDaySelection()
        }
    }
    
    func removeSelection(animated:Bool) -> Void {
        
        guard isSelected == true else {
            return
        }
        
        isSelected = false
        self.dayLabel.font = UIFont.systemFont(ofSize: 17)
        self.dayLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        self.backgroundColor = UIColor.white
        
        if !animated {
            self.removeDaySelection()
        } else {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.removeDaySelection()
            });
        }
    }
    
    func removeDaySelection() -> Void {
        self.dayLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.layer.cornerRadius = 0
        self.clipsToBounds = false
    }
    
    func addDaySelection() -> Void {
        self.dayLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    override var description: String {
        return self.dayLabel.text!
    }
}
