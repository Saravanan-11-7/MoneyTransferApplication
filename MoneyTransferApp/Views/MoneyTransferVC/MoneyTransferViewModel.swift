//
//  MoneyTransferViewModel.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import Foundation
import UIKit

class MoneyTransferViewModel {
    let navTitle = "Money Transfer"
    let infoImage = UIImage(named: "infoQuestionImage")?.withTintColor(UIColor.white)
    let selectionCellIdentifier = "SelectionDropDownTableCell"
    let converterCellIdentifier = "ConverterTableCell"
    
    let countryTitleText = "Country"
    let deliveryTitleText = "Delivery Method"
    let paymentTitleText = "Expected Payment Method"
    
    let countryPlaceholderText = "Select Country"
    let deliveryPlaceholderText = "Select Delivery Method"
    let paymentPlaceholderText = "Select Payment Type"

    var countryData: [Country]?
    var currencyData: CurrencyResponse = CurrencyResponse(result: CurrencyResult(depositCountry: nil, depositCurrency: nil, depositCountryCode: nil, data: nil, timestamp: nil, errorCode: nil, responseStatus: nil, responseMessage: nil, reason: nil))
    var selectedCountry: Country = Country(flags: nil, name: nil, cca2: nil, cioc: nil, currencies: nil, capital: nil, languages: nil)
    var selectedDeliveyMethod: String = ""
    var selectedDeliveryIndexPath: IndexPath?
    
    func placeHolderAttributes(title: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: greenColor,
            .font: UIFont.boldSystemFont(ofSize: 15.0)
        ]
        return  NSAttributedString(string: title, attributes: attributes)
    }
    
    func textAttributes(countryString: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: greenColor,
            .font: UIFont.boldSystemFont(ofSize: 15.0)
        ]
        return  NSAttributedString(string: countryString, attributes: attributes)
    }
    
    func getCountryData(completion: @escaping () -> Void) {
        Service.shared.fetchCountries { result in
            switch result {
            case .success(let data):
                self.countryData = data
                completion()
            case.failure(let error):
                print("Error in fetching:\(error)")
                completion()
            }
        }
    }
    
    func getCurrencyData(completion: @escaping () -> Void) {
        Service.shared.fetchCurrencyData { result in
            switch result {
            case .success(let data):
                self.currencyData = data
                completion()
            case.failure(let error):
                print("Error in fetching:\(error)")
                completion()
            }
        }
    }

    
    func getAEDCountry() -> Country {
        return countryData?.first { country in
            country.currencies?.keys.contains("AED") == true
        } ?? Country(flags: nil, name: nil, cca2: nil, cioc: nil, currencies: nil, capital: nil, languages: nil)
    }
    
    func getInitialSelectedCountry() {
        selectedCountry = countryData?.first { country in
            country.currencies?.keys.contains("INR") == true
        } ?? selectedCountry
    }
    
    
}
