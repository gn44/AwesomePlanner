//
//  APCalendarDayView.swift
//  CalendarTest
//
//  Created by Gints Osis on 18/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarDayView: UIView {

    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var dayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard (dayButton != nil) else {
            return;
        }
        dayButton.addTarget(self, action: #selector(self.dayButtonTap), for: .touchUpInside)
    }
    
    @objc func dayButtonTap(){
        NSLog("here1", "")
    }
    
    override var description: String {
        return self.dayLabel.text!
    }
}
