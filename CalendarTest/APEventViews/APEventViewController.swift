//
//  APEventViewController.swift
//  CalendarTest
//
//  Created by Gints Osis on 29/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventViewController: UIViewController {
    

    @IBOutlet weak var scrollView: APEventScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.centerSecondElement()

        // Do any additional setup after loading the view.
    }

}
