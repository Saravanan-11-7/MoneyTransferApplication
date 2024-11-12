//
//  ViewController.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    private func setupNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
    }
    
    
    @IBAction func didTappedMoneyTransfer(_ sender: Any) {
        let storyBoard = UIStoryboard(name: viewModel.currencyConverterVCIdentifier, bundle:nil)
        let converterVC = storyBoard.instantiateViewController(withIdentifier: viewModel.currencyConverterVCIdentifier)
        navigationController?.pushViewController(converterVC, animated: true)
    }
    

}

