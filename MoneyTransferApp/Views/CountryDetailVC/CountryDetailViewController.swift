//
//  CountryDetailViewController.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 12/11/24.
//

import UIKit

protocol SelectionDelegate: NSObjectProtocol {
    func updateSelectedCountry(_ country: Country)
}

class CountryDetailViewController: UIViewController {

    static let identifier = "CountryDetailViewController"
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: [Country]?
    var allCountries: [Country]?
    var currencyList: CurrencyResponse?
    weak var delegate: SelectionDelegate?
    var viewModel = CountryDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        registerCells()
        searchResults = allCountries ?? []
    }
    
    private func setupDataSource() {
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func registerCells() {
        let popularCell = UINib(nibName: PopularCountryCollectionViewCell.cellID , bundle: nil)
        collectionView.register(popularCell, forCellWithReuseIdentifier: PopularCountryCollectionViewCell.cellID)
        let allCountryCell = UINib(nibName: AllCountryTableViewCell.cellID , bundle: nil)
        tableView.register(allCountryCell, forCellReuseIdentifier: AllCountryTableViewCell.cellID)
    }
    
    private func showAlertForCurrencyNotFound() {
        let alert = UIAlertController(title: viewModel.alertTitle, message: viewModel.alertDesc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: viewModel.alertButtonText, style: .default))
        present(alert, animated: true)
    }
}

// MARK: - CollectionView Delegate & DataSource
extension CountryDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(5, allCountries?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCountryCollectionViewCell.cellID, for: indexPath) as? PopularCountryCollectionViewCell else { return UICollectionViewCell() }
        if let country = allCountries?[indexPath.item] {
            cell.configureData(country: country)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModel.cellWidth, height: viewModel.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCountry = allCountries?[indexPath.item] else { return }
        if let currencyPair = currencyList?.result?.data, currencyPair.contains(where: { $0.currencypair == selectedCountry.currencies?.first?.key }) {
            delegate?.updateSelectedCountry(selectedCountry)
            dismiss(animated: true, completion: nil)
        } else {
            showAlertForCurrencyNotFound()
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension CountryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllCountryTableViewCell.cellID, for: indexPath) as? AllCountryTableViewCell else { return UITableViewCell() }
        if let country = searchResults?[indexPath.row] {
            cell.configureData(country: country)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCountry = searchResults?[indexPath.row] else { return }
        if let currencyPair = currencyList?.result?.data, currencyPair.contains(where: { $0.currencypair == selectedCountry.currencies?.first?.key }) {
            delegate?.updateSelectedCountry(selectedCountry)
            dismiss(animated: true, completion: nil)
        } else {
            showAlertForCurrencyNotFound()
        }
    }
    
}

// MARK: - Search Bar Delegate
extension CountryDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let allCountries = allCountries {
            searchResults = searchText.isEmpty ? allCountries : allCountries.filter {
                $0.name?.common?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
        tableView.reloadData()
    }
}
