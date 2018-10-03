//
//  APEventEmptyTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 03/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventEmptyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var bottomSeparator: UIView!
    @IBOutlet weak var topSeparator: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
