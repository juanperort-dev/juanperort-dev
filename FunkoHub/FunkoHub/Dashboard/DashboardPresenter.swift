//
//  DashboardPresenter.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

protocol DashboardPresenterDelegate: AnyObject {
    func setupCollectionView()
    func reloadData()
    func navigateToFunkoList()
}

class DashboardPresenter: DashboardViewControllerDelegate {
    
    var view: DashboardPresenterDelegate?
    var repository: FunkoRepository = FunkoNativeAPIRespository()
    private var funkoList = [FunkoCollection]()
    
    func setupView() {
        getFunkoCollection()
        view?.setupCollectionView()
    }
    
    private func getFunkoCollection() {
        repository.getFunkoCollection(completion: { funkos in
            self.funkoList = funkos
            self.view?.reloadData()
        })
    }
    
    func getNumberOfRows() -> Int {
        return funkoList.count
    }
    
    func getCellData(index: Int) -> FunkoCollection {
        return funkoList[index]
    }
    
    func navigateToFunkoList() {
        view?.navigateToFunkoList()
    }
}
