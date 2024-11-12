//
//  PopularCountryCollectionViewCell.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 12/11/24.
//

import UIKit

class PopularCountryCollectionViewCell: UICollectionViewCell {
    

    static let cellID = "PopularCountryCollectionViewCell"
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryImage.setRoundedImage()
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
