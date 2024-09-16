//
//  DashboardViewController.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

protocol DashboardViewControllerDelegate: AnyObject {
    func setupView()
    func getNumberOfRows() -> Int
    func getCellData(index: Int) -> FunkoCollection
    func navigateToFunkoList()
}

class DashboardViewController: UIViewController, DashboardPresenterDelegate {
    
    private var presenter: DashboardPresenter = DashboardPresenter()
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func funkosButton(_ sender: UIButton) {
        navigateToFunkoList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.setupView()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: FunkoCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: FunkoCollectionViewCell.id)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func navigateToFunkoList() {
        let storyboard = UIStoryboard(name: Constants.Storyboard.funkoList, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: Constants.Storyboard.funkoList) as? FunkoListViewController else { return }
        navigationController?.show(viewController, sender: nil)
    }
    
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FunkoCollectionViewCell.id, for: indexPath) as? FunkoCollectionViewCell else { return UICollectionViewCell() }
        let data = presenter.getCellData(index: indexPath.row)

        cell.setupDataCell(data)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presenter.navigateToFunkoList()
    }
}
