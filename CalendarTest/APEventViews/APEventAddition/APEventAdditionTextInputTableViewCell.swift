//
//  APEventAdditionTextInputTableViewCell.swift
//  CalendarTest
//
//  Created by Gints Osis on 02/10/2018.
//  Copyright © 2018 EsPats. All rights reserved.
//

import UIKit

protocol APEventAdditionInputCellDelegate: class {
    
    func didTapClosureButton(cell:APEventAdditionTextInputTableViewCell)
    func didTapSelectionButton(cell:APEventAdditionTextInputTableViewCell)
    func textDidChange(cell:APEventAdditionTextInputTableViewCell,newText:String?)
}

class APEventAdditionTextInputTableViewCell: UITableViewCell {

    enum APTextInputCellState:Int
    {
        case text = 0
        case selection
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleTextField.delegate = self;
        self.updateLayout(apLocation: nil, animated: false)
        // Initialization code
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var closureIconImageView: UIImageView!
    @IBOutlet weak var selectionContainerView: UIView!
    @IBOutlet weak var selectionTitleLabel: UILabel!
    @IBOutlet weak var selectionSubtitleLabel: UILabel!
    
    @IBOutlet weak var selectionContainerViewCenterY: NSLayoutConstraint!
    var cellState:APTextInputCellState = .text
    
    var apLocation:APLocationResult?
    
    weak var delegate: APEventAdditionInputCellDelegate?
    
    var type:APEventCreationCellTypes = .empty

    
    public class func reuseIdentifier() -> String {
        return "APEventAdditionTextInputCellReuseIdentifier"
    }
    
    @IBAction func selectionButtonTap(_ sender: Any) {
        
        // disable selection put existing text in the textfield
        if cellState == .selection {
            cellState = .text
            self.titleTextField.becomeFirstResponder()
            self.titleTextField.text = self.selectionTitleLabel.text
            self.updateLayout(apLocation: nil, animated: false)
        }
    }
    
    @IBAction func closureButtonTap(_ sender: Any) {
        
        if cellState == .selection {
            cellState = .text
            self.titleTextField.text = ""
            self.updateLayout(apLocation: nil, animated: true)
            
            self.delegate?.didTapClosureButton(cell: self)
        }
        
    }
    
    public func updateLayout(apLocation:APLocationResult?, animated:Bool) -> Void {
        
        if let location = apLocation {
            self.apLocation = location
            
            // location is about to be displayed
            // animate containerView from the bottom up
            self.selectionContainerViewCenterY.constant = 0
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveLinear, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                //
            }
            
            cellState = .selection
            if location.subTitle.count != 0 {
                
                // unhide subtitle
                self.selectionSubtitleLabel.isHidden = false
                self.selectionSubtitleLabel.text = location.subTitle
            } else {
                
                // hide subtitle
                self.selectionSubtitleLabel.isHidden = true
                self.selectionSubtitleLabel.text = ""
            }
            
            self.selectionTitleLabel.text = location.title
            self.selectionContainerView.isHidden = false
            self.titleTextField.isHidden = true
        } else {
            
            cellState = .text
            self.apLocation = nil
            
            self.titleTextField.isHidden = false
            
            if animated {
                UIView.animate(withDuration: 0.4, animations: {
                    
                    self.selectionContainerView.transform = CGAffineTransform(translationX: -self.frame.size.width, y: 0)
                    self.closureIconImageView.transform = CGAffineTransform(translationX: self.frame.size.width * 2, y: 0)
                    self.selectionContainerView.alpha = 0.0
                }) { (finished) in
                    
                    self.selectionContainerView.isHidden = true
                    self.selectionContainerView.transform = CGAffineTransform.identity
                    self.closureIconImageView.transform = CGAffineTransform.identity
                    self.selectionContainerView.alpha = 1.0
                    self.selectionContainerViewCenterY.constant = self.frame.size.height
                }
            } else {
                self.selectionContainerView.alpha = 1.0
                self.selectionContainerView.isHidden = true
                self.selectionContainerView.transform = CGAffineTransform.identity
                self.closureIconImageView.transform = CGAffineTransform.identity
                self.selectionContainerViewCenterY.constant = self.frame.size.height
            }
            
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension APEventAdditionTextInputTableViewCell:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
                
        self.delegate?.textDidChange(cell: self, newText: newText!)
        
        return true
    }
}
