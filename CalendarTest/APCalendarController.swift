//
//  ViewController.swift
//  CalendarTest
//
//  Created by Gints Osis on 13/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APCalendarViewController: UIViewController {

    @IBOutlet weak var scrollView: APCalendarScrollView!
    
    @IBOutlet weak var seperatorView: UIView!
    let months = [NSLocalizedString("January", comment: ""),
                  NSLocalizedString("February", comment: ""),
                  NSLocalizedString("March", comment: ""),
                  NSLocalizedString("April", comment: ""),
                  NSLocalizedString("May", comment: ""),
                  NSLocalizedString("June", comment: ""),
                  NSLocalizedString("July", comment: ""),
                  NSLocalizedString("August", comment: ""),
                  NSLocalizedString("September", comment: ""),
                  NSLocalizedString("October", comment: ""),
                  NSLocalizedString("November", comment: ""),
                  NSLocalizedString("December", comment: "")]
    
    let days = [NSLocalizedString("Monday", comment: ""),
                NSLocalizedString("Tuesday", comment: ""),
                NSLocalizedString("Wednesday", comment: ""),
                NSLocalizedString("Thursday", comment: ""),
                NSLocalizedString("Friday", comment: ""),
                NSLocalizedString("Saturday", comment: ""),
                NSLocalizedString("Sunday", comment: "")]
    
    let dayCountInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.calenderScrollViewDelegate = self
        scrollView.centerSecondElement()
        
        let additionBarButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
        navigationItem.rightBarButtonItem = additionBarButton
        navigationController?.navigationBar.barTintColor = mainColor
        navigationController?.navigationBar.tintColor = mainTextColor
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: mainTextColor]
        navigationController?.navigationBar.isTranslucent = true
        
        seperatorView.backgroundColor = mainColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.setContentSize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func rightBarButtonTapped() -> Void {
        self.performSegue(withIdentifier: "addEvent", sender: self)
        NSLog("ding", "")
    }
}

extension APCalendarViewController:APCalendarScrollViewDelegate
{
    func calendarScrollViewDidChangeLayout(apCalenderScollView: APCalendarScrollView) {
        
        self.updateViewConstraints()
        
        guard let currentComponents = apCalenderScollView.currentCenteredDateComponents else {
            return;
        }
        
        let currentDate = apCalendar.date(from: currentComponents)
        
        let aPMonth = apCalendar.component(.month, from: currentDate!)
        let aPYear = apCalendar.component(.year, from: currentDate!)
        
        self.navigationItem.title = self.months[aPMonth - 1] + " " + String(aPYear)


    }
}

