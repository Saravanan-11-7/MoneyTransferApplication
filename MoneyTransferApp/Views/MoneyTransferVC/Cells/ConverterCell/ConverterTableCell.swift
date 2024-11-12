//
//  ConverterTableCell.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import UIKit

class ConverterTableCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var depositeView: UIView!
    @IBOutlet weak var recipientView: UIView!
    @IBOutlet weak var exchangeRateView: UIView!
    
    @IBOutlet weak var depositeImage: UIImageView!
    @IBOutlet weak var depositeCountryLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var recipientImage: UIImageView!
    @IBOutlet weak var recipientCountryLabel: UILabel!
    @IBOutlet weak var outputTextField: UITextField!
    
    @IBOutlet weak var convertionImage: UIImageView!
    @IBOutlet weak var convertionValueLabel: UILabel!
    
    static let cellID = "ConverterTableCell"
    
    var defaultCountry: Country?
    var selectedCountry: Country?
    var currencyDataValue: CurrencyResponse?

    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(inputFieldDidChange(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initialSetup() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        depositeView.layer.cornerRadius = 5
        depositeView.layer.borderColor = UIColor.systemGray.cgColor
        depositeView.layer.borderWidth = 0.5
        recipientView.layer.borderColor = UIColor.systemGray.cgColor
        recipientView.layer.borderWidth = 0.5
        exchangeRateView.layer.cornerRadius = 10
        recipientView.layer.cornerRadius = 5
        convertionImage.image = UIImage(named: "convertionImage")?.withTintColor(greenColor)
        inputTextField.setRightPaddingPoints(10)
        outputTextField.setRightPaddingPoints(10)
        depositeImage.setRoundedImage()
        recipientImage.setRoundedImage()
        outputTextField.isUserInteractionEnabled = false
    }
    
    func configuerAEDData(countryAED: Country) {
        self.defaultCountry = countryAED
        Service.shared.downloadImage(from: countryAED.flags?.png ?? "") { image in
            if let countryImage = image {
                self.depositeImage.image = countryImage
            }
        }
        depositeCountryLabel.text = countryAED.currencies?.keys.first
    }
    
    func configureSelectedData(selectedCountry: Country) {
        self.selectedCountry = selectedCountry
        Service.shared.downloadImage(from: selectedCountry.flags?.png ?? "") { image in
            if let countryImage = image {
                self.recipientImage.image = countryImage
            }
        }
        recipientCountryLabel.text = selectedCountry.currencies?.keys.first
    }
    
    @objc func inputFieldDidChange(_ textField: UITextField) {
        guard let inputAmount = textField.text, !inputAmount.isEmpty, let amount = Double(inputAmount) else {
            self.outputTextField.text = ""
            return
        }
        updateOutputField(forAmount: amount)
    }
   
    func updateDefaultConversionRate() {
        guard let exchangeRateSelected = getExchangeRateForSelectedCountry() else {
            convertionValueLabel.text = "Error"
            return
        }
        
        convertionValueLabel.text = String(format: "%.2f", exchangeRateSelected) + " \(selectedCountry?.currencies?.first?.key ?? "")"
    }
    
    func getExchangeRateForAED() -> Double? {
        guard let currencyDataList = currencyDataValue?.result?.data else { return nil }
        if let currencyData = currencyDataList.first(where: { $0.currencypair == "\(selectedCountry?.currencies?.first?.key ?? "")" }) {
            return Double(currencyData.exchangeRate ?? "")
        }
        return nil
    }

    
    func updateOutputField(forAmount amount: Double) {
        guard let exchangeRate = getExchangeRateForSelectedCountry() else {
            outputTextField.text = ""
            return
        }
        let convertedAmount = amount * exchangeRate
        outputTextField.text = String(format: "%.2f", convertedAmount)
    }
    
    private func getExchangeRateForSelectedCountry() -> Double? {
        guard let selectedCountryCode = self.selectedCountry?.currencies?.first?.key,
              let currencyDataList = currencyDataValue?.result?.data else {
            return nil
        }
        
        if let currencyData = currencyDataList.first(where: { $0.currencypair == selectedCountryCode }) {
            return Double(currencyData.exchangeRate ?? "")
        }
        return nil
    }
    
    func setCurrencyData(_ currency: CurrencyResponse) {
        self.currencyDataValue = currency
    }
    
}


extension UIImageView {
    
    func setRoundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
