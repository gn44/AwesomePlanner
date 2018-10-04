//
//  APEventAdditionViewController.swift
//  CalendarTest
//
//  Created by Gints Osis on 29/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

class APEventAdditionViewController: UIViewController {

    enum APEventCreationCellTypes:Int
    {
        case empty = 0
        case title
        case location
        case daily
        case start
        case end
        case repeats
        case alert
        case url
        case notes
        case datePicker
    }
    
    var dataSource = [APEventCreationCellTypes]()
    
    public var startDate:Date!
    public var endDate:Date!
    
    var startOpened:Bool = false
    var endOpened:Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if startDate == nil {
            startDate = apCalendar.date(bySettingHour: 23, minute: 0, second: 0, of: Date())
            
            endDate = apCalendar.date(byAdding: .hour, value: 1, to: startDate)
        }
        
        self.title = NSLocalizedString("New event", comment: "")
        
        tableView.tableFooterView = UIView.init()
        
        dataSource = [.empty,.title,.location,.empty,.daily,.start,.end,.repeats,.empty,.alert,.empty,.url]
        
    }
    
    
    func addDatePickerAfterIndexPath(indexPath:IndexPath) -> Void {
        let index = indexPath.row + 1
        
        dataSource .insert(.datePicker, at: index)
        
        self.tableView.beginUpdates()
        self.tableView .insertRows(at: [IndexPath(row: index, section: indexPath.section)], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
        
    }
    
    func removeDatePickerAfterIndexPath(indexPath:IndexPath) -> Void {
        
        let index = indexPath.row + 1
        dataSource.remove(at: index)
        
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [IndexPath(row: index, section: indexPath.section)], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
}

// MARK: UITableViewDelegate and UITableViewDataSource

extension APEventAdditionViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]
        
        var cellIdentifier = ""
        
        switch cellType {
        case .title,.location,.url:
            cellIdentifier = APEventAdditionTextInputTableViewCell.reuseIdentifier()
            break
        case .daily:
            cellIdentifier = APEventAdditionCheckmarkTableViewCell.reuseIdentifier()
            break
        case .start, .end:
            cellIdentifier = APEventAdditionSubtitleTableViewCell.reuseIdentifier()
            break
        case .alert,.repeats:
            cellIdentifier = APEventAdditionClosureTableViewCell.reuseIdentifier()
        case .empty:
            cellIdentifier = "EmptyCell"
        case .datePicker:
            cellIdentifier = APEventDatePickerTableViewCell.reuseIdentifier()
            
        default:
            cellIdentifier = ""
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellType = dataSource[indexPath.row]
        
        if cellType == .empty {
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            if dataSource.count > indexPath.row + 1
            {
                let nextCellType = dataSource[indexPath.row + 1]
                if nextCellType == .empty {
                    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
                }
            } else {
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            }
        }
        
        
        switch cellType {
        case .title:
            let cell:APEventAdditionTextInputTableViewCell = cell as! APEventAdditionTextInputTableViewCell
            cell.titleTextField.placeholder = NSLocalizedString("Title", comment: "")

        case .location:
            let cell:APEventAdditionTextInputTableViewCell = cell as! APEventAdditionTextInputTableViewCell
            cell.titleTextField.placeholder = NSLocalizedString("Location", comment: "")
            
        case .daily:
            let cell:APEventAdditionCheckmarkTableViewCell = cell as! APEventAdditionCheckmarkTableViewCell
            cell.titleLabel.text = NSLocalizedString("All-day", comment: "")
            cell.optionSwitch.onTintColor = Colors.lighterGreen
            cell.optionSwitch.tintColor = Colors.lighterGreen
            
        case .start,.end:
            let cell:APEventAdditionSubtitleTableViewCell = cell as! APEventAdditionSubtitleTableViewCell
            if cellType == .start {
                
                cell.titleLabel.text = NSLocalizedString("Starts", comment: "")
                cell.subtitleLabel.text = APCalendarUtilities.shared().eventCreationDateFormatter.string(from: startDate)
            } else {
                
                cell.titleLabel.text = NSLocalizedString("Ends", comment: "")
                cell.subtitleLabel.text = APCalendarUtilities.shared().eventCreationHourFormatter.string(from: endDate)
            }
            
        case .repeats,.alert:
            let cell:APEventAdditionClosureTableViewCell = cell as! APEventAdditionClosureTableViewCell
            
            if cellType == .repeats {
                
                cell.titleLabel.text = NSLocalizedString("Repeats", comment: "")
                cell.subtitleLabel.text = NSLocalizedString("Never", comment: "")
            } else {
                
                cell.titleLabel.text = NSLocalizedString("Alert", comment: "")
                cell.subtitleLabel.text = NSLocalizedString("None", comment: "")
            }
            
        case .url:
            let cell:APEventAdditionTextInputTableViewCell = cell as! APEventAdditionTextInputTableViewCell
            cell.titleTextField.placeholder = NSLocalizedString("URL", comment: "")
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = dataSource[indexPath.row]
        if indexPath.row == 0 {
            return 22
        }
        
        if cellType == .datePicker
        {
            return 216
        }
        
        
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellType = dataSource[indexPath.row]
        
        self.tableView .deselectRow(at: indexPath, animated: true)
        
        if cellType == .start {
            if self.startOpened {
                
                self.startOpened = false
                self.removeDatePickerAfterIndexPath(indexPath: indexPath)
            } else {
                
                self.startOpened = true
                self.addDatePickerAfterIndexPath(indexPath: indexPath)
            }
        } else if cellType == .end {
            
            if self.endOpened {
                
                self.endOpened = false
                self.removeDatePickerAfterIndexPath(indexPath: indexPath)
            } else {
                self.endOpened = true
                self.addDatePickerAfterIndexPath(indexPath: indexPath)
            }
        }
    }
    
    
}
