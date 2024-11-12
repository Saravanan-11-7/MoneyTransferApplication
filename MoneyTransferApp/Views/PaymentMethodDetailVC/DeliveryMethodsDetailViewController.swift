//
//  PaymentMethodsDetailViewController.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 12/11/24.
//

import UIKit

protocol DeliveryMethodsDelegate: NSObjectProtocol {
    func updateDeliveryMethods(method: String, indexPath: IndexPath)
}

class DeliveryMethodsDetailViewController: UIViewController {
    
    static let identifier = "DeliveryMethodsDetailViewController"
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = DeliveryMethodsDetailViewModel()
    var selectedIndexPath: IndexPath?
    weak var delegate: DeliveryMethodsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
    }
    
    private func registerCell() {
        let cell = UINib(nibName: DeliveryDetailTableViewCell.cellID, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: DeliveryDetailTableViewCell.cellID)
    }

}

// MARK: - Datasource Methods
extension DeliveryMethodsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryDetailTableViewCell.cellID, for: indexPath) as? DeliveryDetailTableViewCell else { return UITableViewCell() }
        cell.paymentValueLabel.text = viewModel.deliveryMethods[indexPath.section]
        cell.paymentMethodImage.image = viewModel.getDeliveryImages(data: viewModel.deliveryMethods[indexPath.section])
        if indexPath == selectedIndexPath {
            cell.selectionImage.image = viewModel.getDeliveryImages(data:viewModel.selectedImage)
            cell.layer.borderColor = viewModel.selectedColour
            cell.layer.borderWidth = 2.0
        } else {
            cell.selectionImage.image = viewModel.getDeliveryImages(data:viewModel.deselectedImage)
            cell.layer.borderColor = viewModel.deSelectedColour
            cell.layer.borderWidth = 0.5
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Delegate Methods
extension DeliveryMethodsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
            delegate?.updateDeliveryMethods(method: viewModel.deliveryMethods[indexPath.section], indexPath: indexPath)
            dismiss(animated: true)
        }
        tableView.reloadData()
    }
}
