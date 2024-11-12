//
//  PaymentMethodsDetailViewModel.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 12/11/24.
//

import Foundation
import UIKit


class DeliveryMethodsDetailViewModel {
    
    let deliveryMethods = ["Back Account", "Cash Pickup", "Mobile Wallet"]
    let selectedImage = "selectedCheck"
    let deselectedImage = "deSelectCheck"
    let selectedColour = UIColor.systemGreen.cgColor
    let deSelectedColour = UIColor.lightGray.cgColor
    
    func getDeliveryImages(data: String) -> UIImage {
        return UIImage(named: data) ?? UIImage()
    }
    
}
