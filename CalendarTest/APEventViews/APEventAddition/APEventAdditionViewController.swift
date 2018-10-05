//
//  APEventAdditionViewController.swift
//  CalendarTest
//
//  Created by Gints Osis on 29/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit
import MapKit

class APEventAdditionViewController: UIViewController {

    enum APEventCreationCellTypes:Int
    {
        case empty = 0
        case title
        case location
        case locationResult
        case daily
        case start
        case end
        case repeats
        case alert
        case url
        case notes
        case datePicker
    }
    
    var dataSource = [[APEventCreationCellTypes]]()
    var locationDataSource = [MKMapItem]()
    let locationRowSection = 1
    
    public var startDate:Date!
    public var endDate:Date!
    
    var startOpened:Bool = false
    var endOpened:Bool = false
    
    let locationSearcher = APLocationSearcher.init()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationSearcher.delegate = self
        
        if startDate == nil {
            startDate = apCalendar.date(bySettingHour: 23, minute: 0, second: 0, of: Date())
            
            endDate = apCalendar.date(byAdding: .hour, value: 1, to: startDate)
        }
        
        self.title = NSLocalizedString("New event", comment: "")
        
        tableView.tableFooterView = UIView.init()
        
        dataSource = [[.empty,.title,.location],[.empty,.daily,.start,.end,.repeats,.empty,.alert,.empty,.url]]
        
    }
    
    // MARK: cell addition/removal
    
    func refreshLocationResultsCell() -> Void {
        
        let locationSection = dataSource[locationRowSection]
        
        let anyIndex = Int(arc4random_uniform(UInt32(locationSection.count)))
        let anyLocation = locationSection[anyIndex]
        
        let locationResultsArray = Array<APEventCreationCellTypes>(repeating:.locationResult , count: locationDataSource.count)
        
        if anyLocation != .locationResult
        {
            // this section doesn't contain only location results we must add location section
            dataSource .insert(locationResultsArray, at: locationRowSection)
            
            self.tableView.beginUpdates()
            self.tableView.insertSections(IndexSet(arrayLiteral: locationRowSection), with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        } else {
            
            dataSource.remove(at: locationRowSection)
            dataSource .insert(locationResultsArray, at: locationRowSection)
            self.tableView.beginUpdates()
            self.tableView.deleteSections(IndexSet(arrayLiteral: locationRowSection), with: UITableViewRowAnimation.none)
            self.tableView.insertSections(IndexSet(arrayLiteral: locationRowSection), with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
            // remove existing section and
        }
    }
    
    func addDatePickerAfterIndexPath(indexPath:IndexPath) -> Void {
        let index = indexPath.row + 1
        
        var elements = dataSource[indexPath.section]
        
        elements .insert(.datePicker, at: index)
        
        dataSource[indexPath.section] = elements
        
        self.tableView.beginUpdates()
        self.tableView .insertRows(at: [IndexPath(row: index, section: indexPath.section)], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
        
    }
    
    func removeDatePickerAfterIndexPath(indexPath:IndexPath) -> Void {
    
        var elements = dataSource[indexPath.section]
        
        let index = indexPath.row + 1
        elements.remove(at: index)
        
        dataSource[indexPath.section] = elements
        
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [IndexPath(row: index, section: indexPath.section)], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
}

// MARK: UITableViewDelegate and UITableViewDataSource

extension APEventAdditionViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let elements = dataSource[section]
        
        return elements.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elements = dataSource[indexPath.section]
        let cellType = elements[indexPath.row]
        
        var cellIdentifier = ""
        
        switch cellType {
        case .title,.location,.url:
            cellIdentifier = APEventAdditionTextInputTableViewCell.reuseIdentifier()
            break
        case .locationResult:
            cellIdentifier = APLocationTableViewCell.reuseIdentifier()
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
        
        let elements = dataSource[indexPath.section]
        let cellType = elements[indexPath.row]
        
        if cellType == .empty {
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        } else {
            if elements.count > indexPath.row + 1
            {
                let nextCellType = elements[indexPath.row + 1]
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
            cell.titleTextField.delegate = self.locationSearcher
            
        case .locationResult:
            let cell:APLocationTableViewCell = cell as! APLocationTableViewCell
            let mapItem:MKMapItem = locationDataSource[indexPath.row]
            cell.titleLabel.text = mapItem.name
            
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
        
        let elements = dataSource[indexPath.section]
        let cellType = elements[indexPath.row]
        
        if indexPath.row == 0 && indexPath.section == 0 {
            return 22
        }
        
        if cellType == .datePicker
        {
            return 216
        }
        
        
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let elements = dataSource[indexPath.section]
        let cellType = elements[indexPath.row]
        
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

extension APEventAdditionViewController:APLocationSearchResultsDelegate
{
    func locationSearcherDidReturnResults(results: [MKMapItem]) {
        
        self.locationDataSource = results
        self.refreshLocationResultsCell()
    }
}
