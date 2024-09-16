//
//  FunkoListViewController.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

protocol FunkoListViewControllerDelegate: AnyObject {
    func navigateToFilter(defaultData: KeyDataFunkos, filteredData: KeyDataFunkos)
    func navigateToDetail(index: Int)
    func updateTableView()
    func setupTableView()
    func setupDefaultValue()
    func showTableView()
}

class FunkoListViewController: UIViewController, FunkoListViewControllerDelegate {
  
    @IBOutlet weak var labelEmptyList: UILabel!
    @IBOutlet public weak var tableView: UITableView!
    
    private let presenter: FunkoListPresenter = FunkoListPresenter()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.updateView()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        presenter.backButtonAction()
    }
    
    func setupDefaultValue() {
        presenter.getDefaultValue()
    }
    
    func showTableView() {
        tableView.isHidden = false
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func navigateToFilter(defaultData: KeyDataFunkos, filteredData: KeyDataFunkos) {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.funkoFilter, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(identifier: Constants.Storyboard.funkoFilter) as? FunkoFilterViewController else { return }
        viewController.delegate = presenter
        viewController.presenter.setDefaultData(defaultData)
        viewController.presenter.setChangedData(filteredData)
        navigationController?.show(viewController, sender: nil)
    }
    
    func navigateToDetail(index: Int) {
        
//        let storyboard: UIStoryboard = UIStoryboard(name: Constants.Storyboard.funkoDetail, bundle: nil)
//        guard let viewController: DetalleViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.funkoDetail) as? FunkoDetailViewController
//        else { return }
//        
//        viewController.delegate = self
//        viewController.presentador.funko = presenter.getCellData(index: index)
//        
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FunkoListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FunkoListCell.id, for: indexPath) as? FunkoListCell else {
            return UITableViewCell()
        }
        let data = presenter.getCellData(index: indexPath.row)
        cell.setupDataCell(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
     }
}
