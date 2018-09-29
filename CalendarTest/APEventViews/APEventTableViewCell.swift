//
//  APEventTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 29/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier() -> String {
        return "APEventCellIdentifier"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
