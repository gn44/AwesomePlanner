//
//  APEventAdditionViewController.swift
//  CalendarTest
//
//  Created by Gints Osis on 29/09/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit
import MapKit

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

class APEventAdditionViewController: UIViewController {
    
    var dataSource = [[APEventCreationCellTypes]]()
    var locationDataSource = [APLocationResult]()
    let locationRowSection = 1
    
    var startOpened:Bool = false
    var endOpened:Bool = false
    
    let locationSearcher = APLocationSearcher.init()
    let updateQueue:OperationQueue = OperationQueue.init()
    
    @IBOutlet weak var tableView: UITableView!
    
    // selected variables
    var selectedLocationResult:APLocationResult?
    var selectedStartDate:Date?
    var selectedEndDate:Date?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.updateQueue.maxConcurrentOperationCount = 1
        
        locationSearcher.delegate = self
        
        if self.selectedStartDate == nil {
            self.selectedStartDate = apCalendar.date(bySettingHour: 23, minute: 0, second: 0, of: Date())
            
            self.selectedEndDate = apCalendar.date(byAdding: .hour, value: 1, to: self.selectedStartDate!)
        }
        
        self.title = NSLocalizedString("New event", comment: "")
        
        tableView.tableFooterView = UIView.init()
        
        dataSource = [[.empty,.title,.location],[.empty,.daily,.start,.end,.repeats,.empty,.alert,.empty,.url]]
        
    }
    
    // MARK: cell addition/removal
    
    func refreshLocationResultsCell() -> Void {
        
        
        let locationSection = dataSource[locationRowSection]

        if locationSection.count == 0 {
            
            return
        }
        
        let anyIndex = Int(arc4random_uniform(UInt32(locationSection.count)))
        let anyLocation = locationSection[anyIndex]
        
        let locationResultsArray = Array<APEventCreationCellTypes>(repeating:.locationResult , count: locationDataSource.count)
        
        // do not add new section if datasource is empty
        if anyLocation != .locationResult
        {
            if self.locationDataSource.count == 0 {
                return
            }
            
            // this section doesn't contain only location results we must add location section
            dataSource .insert(locationResultsArray, at: locationRowSection)
            
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.insertSections(IndexSet(arrayLiteral: self.locationRowSection), with: UITableViewRowAnimation.fade)
                self.tableView.endUpdates()
            }
        } else {
            
            dataSource.remove(at: locationRowSection)
            
            
            DispatchQueue.main.async {
                if self.locationDataSource.count != 0 {
                    
                    self.dataSource .insert(locationResultsArray, at: self.locationRowSection)
                }
                
                self.tableView.beginUpdates()
                self.tableView.deleteSections(IndexSet(arrayLiteral: self.locationRowSection), with: UITableViewRowAnimation.none)
                
                if self.locationDataSource.count != 0 {
                    self.tableView.insertSections(IndexSet(arrayLiteral: self.locationRowSection), with: UITableViewRowAnimation.fade)
                }
                self.tableView.endUpdates()
            }
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
    
    func updateLocationInputCellWithLocation(apLocation:APLocationResult?) -> Void {
        
        if apLocation != nil {
            
            self.updateLocationSectionWithResults(results: [])
        }
        
        guard let locationCell:APEventAdditionTextInputTableViewCell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? APEventAdditionTextInputTableViewCell else {
            
            return
        }
        
        locationCell.updateLayout(apLocation: apLocation, animated: true)
        
    }
    
    func updateLocationSectionWithResults(results: [APLocationResult]) -> Void {
        
        let updateOperation = BlockOperation.init {
            self.locationDataSource = results
            self.refreshLocationResultsCell()
        }
        
        self.updateQueue.addOperation(updateOperation)
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
            cell.titleTextField.returnKeyType = UIReturnKeyType.next
            cell.type = .title

        case .location:
            let cell:APEventAdditionTextInputTableViewCell = cell as! APEventAdditionTextInputTableViewCell
            cell.titleTextField.placeholder = NSLocalizedString("Location", comment: "")
            cell.titleTextField.returnKeyType = UIReturnKeyType.search
            cell.type = .location
            cell.delegate = self
            cell.updateLayout(apLocation: self.selectedLocationResult, animated: false)
            
        case .locationResult:
            let cell:APLocationTableViewCell = cell as! APLocationTableViewCell
            let locationResult:APLocationResult = locationDataSource[indexPath.row]
            cell.titleLabel.text = locationResult.title
            if locationResult.subTitle.count != 0 {
                
                cell.subtitleLabel.isHidden = false
                cell.subtitleLabel.text = locationResult.subTitle
            } else {
                
                cell.subtitleLabel.isHidden = true
            }
            
        case .daily:
            let cell:APEventAdditionCheckmarkTableViewCell = cell as! APEventAdditionCheckmarkTableViewCell
            cell.titleLabel.text = NSLocalizedString("All-day", comment: "")
            cell.optionSwitch.onTintColor = Colors.lighterGreen
            cell.optionSwitch.tintColor = Colors.lighterGreen
            
        case .start,.end:
            let cell:APEventAdditionSubtitleTableViewCell = cell as! APEventAdditionSubtitleTableViewCell
            if cellType == .start {
                
                cell.titleLabel.text = NSLocalizedString("Starts", comment: "")
                cell.subtitleLabel.text = APCalendarUtilities.shared().eventCreationDateFormatter.string(from: self.selectedStartDate!)
            } else {
                
                cell.titleLabel.text = NSLocalizedString("Ends", comment: "")
                
                if APCalendarUtilities.shared().isDate(date: self.selectedStartDate!, inSameDayAsDate: self.selectedEndDate!) {
                    
                    cell.subtitleLabel.text = APCalendarUtilities.shared().eventCreationHourFormatter.string(from: self.selectedEndDate!)
                } else {
                    
                cell.subtitleLabel.text = APCalendarUtilities.shared().eventCreationDateFormatter.string(from: self.selectedEndDate!)
                }
            }
        case .datePicker:
            let cell:APEventDatePickerTableViewCell = cell as! APEventDatePickerTableViewCell
            let previousCellType = elements[indexPath.row - 1]
            
            if previousCellType == .start {
                
                cell.datePicker.setDate(self.selectedStartDate!, animated: false)
            } else {
                
                cell.datePicker.setDate(self.selectedEndDate!, animated: false)
            }
            
            // asign datepicker type to the cell that this picker is for
            cell.type = previousCellType
            cell.delegate = self
            
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
        } else if cellType == .locationResult {
            
            let selectedLocation:APLocationResult = self.locationDataSource[indexPath.row]
            
            self.selectedLocationResult = selectedLocation
            self.updateLocationInputCellWithLocation(apLocation: selectedLocation)
            
            self.view.endEditing(true)
        }
    }
    
}

extension APEventAdditionViewController:APLocationSearchResultsDelegate
{
    func locationSearcherDidReturnResults(results: [APLocationResult]) {
        
        self.updateLocationSectionWithResults(results: results)
    }
}

extension APEventAdditionViewController:APEventAdditionInputCellDelegate
{
    func textDidChange(cell: APEventAdditionTextInputTableViewCell, newText: String?) {
        if cell.type == .location {
            self.locationSearcher .searchLocationWithText(searchText: "airport")
        }
    }
    
    func didTapClosureButton(cell: APEventAdditionTextInputTableViewCell) {
        
        if self.selectedLocationResult != nil {
            self.selectedLocationResult = nil
        }
    }
    
    func didTapSelectionButton(cell: APEventAdditionTextInputTableViewCell) {
        //
    }
}

extension APEventAdditionViewController:APEventDatePickerDelegate {
    
    func datePickerValueChanged(cell: APEventDatePickerTableViewCell, date: Date) {
        
        switch cell.type {
        case .start:
            self.selectedStartDate = date
            break
        case .end:
            self.selectedEndDate = date
            break
        default:
            break
            
        }
        
        // reload previous cell
        var indexPath:IndexPath = self.tableView.indexPath(for: cell)!
        indexPath.row -= 1
        
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView .reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            self.tableView.endUpdates()
        }
        
        
    }
}
