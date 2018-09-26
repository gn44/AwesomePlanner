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
    
    
    func addToMultiSelection() -> Void {
        UIView .animate(withDuration: 0.1) {
            self.backgroundColor = UIColor.green
        }
        self.startWiggle()
    }
    
    func removeFromMultiSelection() -> Void {
        self.layer.removeAllAnimations()
        self.backgroundColor = UIColor.white
    }
    
    private func degreesToRadians(_ x: CGFloat) -> CGFloat {
        return .pi * x / 180.0
    }
    
    func startWiggle(
        duration: Double = 0.25,
        displacement: CGFloat = 1.0,
        degreesRotation: CGFloat = 2.0
        ) {
        let negativeDisplacement = -1.0 * displacement
        let position = CAKeyframeAnimation.init(keyPath: "position")
        position.beginTime = 0.8
        position.duration = duration
        position.values = [
            NSValue(cgPoint: CGPoint(x: negativeDisplacement, y: negativeDisplacement)),
            NSValue(cgPoint: CGPoint(x: 0, y: 0)),
            NSValue(cgPoint: CGPoint(x: negativeDisplacement, y: 0)),
            NSValue(cgPoint: CGPoint(x: 0, y: negativeDisplacement)),
            NSValue(cgPoint: CGPoint(x: negativeDisplacement, y: negativeDisplacement))
        ]
        position.calculationMode = "linear"
        position.isRemovedOnCompletion = false
        position.repeatCount = Float.greatestFiniteMagnitude
        position.beginTime = CFTimeInterval(Float(arc4random()).truncatingRemainder(dividingBy: Float(25)) / Float(100))
        position.isAdditive = true
        
        let transform = CAKeyframeAnimation.init(keyPath: "transform")
        transform.beginTime = 2.6
        transform.duration = duration
        transform.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        transform.values = [
            degreesToRadians(-1.0 * degreesRotation),
            degreesToRadians(degreesRotation),
            degreesToRadians(-1.0 * degreesRotation)
        ]
        transform.calculationMode = "linear"
        transform.isRemovedOnCompletion = false
        transform.repeatCount = Float.greatestFiniteMagnitude
        transform.isAdditive = true
        transform.beginTime = CFTimeInterval(Float(arc4random()).truncatingRemainder(dividingBy: Float(25)) / Float(100))
        
        self.layer.add(position, forKey: nil)
        self.layer.add(transform, forKey: nil)
    }
}
