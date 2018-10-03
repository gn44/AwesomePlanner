//
//  APEventAdditionTextInputTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 02/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventAdditionTextInputTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    class func reuseIdentifier() -> String {
        return "APEventAdditionTextInputCellReuseIdentifier"
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
