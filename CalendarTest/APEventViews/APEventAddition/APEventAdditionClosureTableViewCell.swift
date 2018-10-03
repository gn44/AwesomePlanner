//
//  APEventAdditionClosureTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 02/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventAdditionClosureTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    class func reuseIdentifier() -> String {
        return "APEventAdditionClosureCellReuseIdentifier"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
