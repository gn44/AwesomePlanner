//
//  APEventAdditionCheckmarkTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 03/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventAdditionCheckmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier() -> String {
        return "APEventAdditionCheckmarkCellReuseIdentifier"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
