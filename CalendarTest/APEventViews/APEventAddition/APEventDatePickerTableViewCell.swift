//
//  APEventDatePickerTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 03/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventDatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier() -> String {
        return "APEventDatePickerCellReuseIdentifier"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
