//
//  APEventDatePickerTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 03/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

protocol APEventDatePickerDelegate:class {
    func datePickerValueChanged(cell:APEventDatePickerTableViewCell, date:Date)
}

class APEventDatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: APEventDatePickerDelegate?
    
    var type:APEventCreationCellTypes = .empty
    
    override func awakeFromNib() {
        
        self.datePicker.calendar = apCalendar
        self.datePicker.timeZone = TimeZone(abbreviation: "UTC")
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier() -> String {
        return "APEventDatePickerCellReuseIdentifier"
    }
    @IBAction func datePickerValueChanged(_ sender: Any) {
        self.delegate?.datePickerValueChanged(cell: self, date: self.datePicker.date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
