//
//  PaymentDetailTableViewCell.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 12/11/24.
//

import UIKit

class DeliveryDetailTableViewCell: UITableViewCell {

    static let cellID = "DeliveryDetailTableViewCell"
    
    @IBOutlet weak var paymentMethodImage: UIImageView!
    @IBOutlet weak var selectionImage: UIImageView!
    @IBOutlet weak var paymentValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func initialSetup() {
        selectionImage.setRoundedImage()
        paymentMethodImage.setRoundedImage()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
