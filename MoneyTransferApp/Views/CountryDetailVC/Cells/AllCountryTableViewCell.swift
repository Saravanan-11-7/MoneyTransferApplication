//
//  AllCountryTableViewCell.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 12/11/24.
//

import UIKit

class AllCountryTableViewCell: UITableViewCell {
    
    static let cellID = "AllCountryTableViewCell"
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryImage.setRoundedImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(country: Country) {
        Service.shared.downloadImage(from: country.flags?.png ?? "") { image in
            if let countryImage = image {
                self.countryImage.image = countryImage
            }
        }
        countryLabel.text = country.name?.common
    }
    
}
