//
//  SelectionDropDownTableCell.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import UIKit

class SelectionDropDownTableCell: UITableViewCell {
    
    static let cellID = "SelectionDropDownTableCell"
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var dropDownImage: UIImageView!
    @IBOutlet weak var selectionTextField: UITextField!
    @IBOutlet weak var dropDownView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initialSetup() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        dropDownView.layer.cornerRadius = 10
        selectionTextField.setLeftPaddingPoints(10)
        selectionTextField.isUserInteractionEnabled = false
    }
    
}

extension UITextField {
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
