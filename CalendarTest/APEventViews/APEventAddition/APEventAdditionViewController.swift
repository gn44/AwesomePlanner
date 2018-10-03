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
    }
    
    var dataSource = [APEventCreationCellTypes]()
    
    public var startDate:Date!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView.init()
        
        dataSource = [.empty,.title,.location,.empty,.daily,.start,.end,.repeats,.empty,.alert,.empty,.url]
        
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
        case .start, .end,.repeats,.alert:
            cellIdentifier = APEventAdditionClosureTableViewCell.reuseIdentifier()
            break
        case .empty:
            cellIdentifier = "EmptyCell"
            
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
            
        case .start,.end:
            let cell:APEventAdditionClosureTableViewCell = cell as! APEventAdditionClosureTableViewCell
            if cellType == .start {
                
                cell.titleLabel.text = NSLocalizedString("Starts", comment: "")
            } else {
                
                cell.titleLabel.text = NSLocalizedString("Ends", comment: "")
            }
            cell.subtitleLabel.text = ""
            
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
        
        if indexPath.row == 0 {
            return 22
        }
        
        return 44
    }
    
    
}
