//
//  APEventLocationTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 05/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier() -> String {
        return "APLocationTableViewCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
