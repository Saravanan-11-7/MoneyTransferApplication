//
//  MoneyTransferViewController.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import UIKit

let greenColor = UIColor(red: 0/255.0, green: 169/255.0, blue: 30/255.0, alpha: 255/255.0)

class MoneyTransferViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = MoneyTransferViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        registerCells()
        setupDataSource()
        fetchCountryData()
        fetchCurrencyData()
    }
    
    private func setupNavBar() {
        self.view.backgroundColor = greenColor
        navigationItem.title = viewModel.navTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func registerCells() {
        tableView.showsVerticalScrollIndicator = false
        let selectionCell = UINib(nibName: SelectionDropDownTableCell.cellID , bundle: nil)
        tableView.register(selectionCell, forCellReuseIdentifier: SelectionDropDownTableCell.cellID)
        
        let converterCell = UINib(nibName: ConverterTableCell.cellID, bundle: nil)
        tableView.register(converterCell, forCellReuseIdentifier: ConverterTableCell.cellID)
    }
    
    private func setupDataSource() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchCountryData() {
        viewModel.getCountryData {
            self.viewModel.getInitialSelectedCountry()
            self.reloadCells()
        }
    }
    
    private func reloadCells() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func fetchCurrencyData() {
        viewModel.getCurrencyData {
            
        }
    }

}

// MARK: - TableView DataSource
extension MoneyTransferViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return self.tableView(tableView, countryCell: indexPath)
        } else if indexPath.section == 1 {
            return self.tableView(tableView, deliveryCell: indexPath)
        } else if indexPath.section == 2 {
            return self.tableView(tableView, converterCell: indexPath)
        } else if indexPath.section == 3 {
            return self.tableView(tableView, paymentMethodCell: indexPath)
        } else {
            return UITableViewCell()
        }
    }
}

extension MoneyTransferViewController {
    func tableView(_ tableView: UITableView, countryCell indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionDropDownTableCell.cellID , for: indexPath) as? SelectionDropDownTableCell else {
            return UITableViewCell()
        }
        cell.selectionTextField.attributedText = viewModel.textAttributes(countryString: viewModel.selectedCountry.name?.common ?? "")
        cell.cellTitleLabel.text = viewModel.countryTitleText
        cell.selectionTextField.attributedPlaceholder = viewModel.placeHolderAttributes(title: viewModel.countryPlaceholderText )
        return cell
    }
    
    func tableView(_ tableView: UITableView, deliveryCell indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionDropDownTableCell.cellID , for: indexPath) as? SelectionDropDownTableCell else {
            return UITableViewCell()
        }
        cell.selectionTextField.attributedText = viewModel.textAttributes(countryString: viewModel.selectedDeliveyMethod)
        cell.cellTitleLabel.text = viewModel.deliveryTitleText
        cell.selectionTextField.attributedPlaceholder = viewModel.placeHolderAttributes(title: viewModel.deliveryPlaceholderText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, converterCell indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConverterTableCell.cellID , for: indexPath) as? ConverterTableCell else {
            return UITableViewCell()
        }
        cell.configuerAEDData(countryAED: viewModel.getAEDCountry())
        cell.configureSelectedData(selectedCountry: viewModel.selectedCountry)
        cell.setCurrencyData(viewModel.currencyData)
        cell.updateDefaultConversionRate()
        cell.updateOutputField(forAmount: 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, paymentMethodCell indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionDropDownTableCell.cellID , for: indexPath) as? SelectionDropDownTableCell else {
            return UITableViewCell()
        }
        cell.selectionTextField.attributedText = viewModel.textAttributes(countryString: "")
        cell.cellTitleLabel.text = viewModel.paymentTitleText
        cell.selectionTextField.attributedPlaceholder = viewModel.placeHolderAttributes(title: viewModel.paymentPlaceholderText)
        return cell
    }
}

//MARK: - TableView Delegate
extension MoneyTransferViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard(name: CountryDetailViewController.identifier, bundle: nil)
            if let countryDetailVC = storyboard.instantiateViewController(withIdentifier: CountryDetailViewController.identifier) as? CountryDetailViewController {
                countryDetailVC.modalPresentationStyle = .pageSheet
                countryDetailVC.allCountries = viewModel.countryData
                countryDetailVC.currencyList = viewModel.currencyData
                countryDetailVC.delegate = self
                if let sheet = countryDetailVC.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                present(countryDetailVC, animated: true)
            }
        } else if indexPath.section == 1 {
            let storyboard = UIStoryboard(name: DeliveryMethodsDetailViewController.identifier, bundle: nil)
            if let paymentDetailVC = storyboard.instantiateViewController(withIdentifier: DeliveryMethodsDetailViewController.identifier) as? DeliveryMethodsDetailViewController {
                paymentDetailVC.modalPresentationStyle = .pageSheet
                paymentDetailVC.delegate = self
                paymentDetailVC.selectedIndexPath = viewModel.selectedDeliveryIndexPath
                if let sheet = paymentDetailVC.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                present(paymentDetailVC, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Delegates for country and delivery selection
extension MoneyTransferViewController:SelectionDelegate, DeliveryMethodsDelegate {
    func updateSelectedCountry(_ country: Country) {
        self.viewModel.selectedCountry = country
        self.reloadCells()
    }
    
    func updateDeliveryMethods(method: String, indexPath: IndexPath) {
        self.viewModel.selectedDeliveyMethod = method
        self.viewModel.selectedDeliveryIndexPath = indexPath
        self.reloadCells()
    }
    
}
