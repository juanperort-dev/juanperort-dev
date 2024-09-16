//
//  FunkoListPresenter.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

protocol PresentadorFunkoListDelegate: AnyObject {
    func backButtonAction()
    func didSelectRowAt(index: Int)
    func getNumberOfRows() -> Int
    func updateView()
    func getDefaultValue()
    func getCellData(index: Int) -> Funko
}

final class FunkoListPresenter {
    
    var view: FunkoListViewControllerDelegate?
    var repository: FunkoRepository = FunkoNativeAPIRespository()
    
    private var defaultData: KeyDataFunkos = KeyDataFunkos()
    private var filteredData: KeyDataFunkos = KeyDataFunkos()

    private func setupDefaultValue(funkos: [Funko]) {
        defaultData.funkoList = funkos
        
        setupDefaultData()
        setupFilteredData()
    }
    
    private func setupDefaultData() {
        setupDefaultPrice()
        setupDefaultDate()
        setupDefaultType()
    }
    
    private func setupDefaultPrice() {
        defaultData.maxPrice = defaultData.funkoList.compactMap { $0.price }.reduce(Constants.Numeric.priceMinValue, { max($0, $1) })
        defaultData.minPrice = defaultData.funkoList.compactMap { $0.price }.reduce(Constants.Numeric.priceMaxValue, { min($0, $1) })
    }
    private func setupDefaultDate() {
        defaultData.maxDate = defaultData.funkoList.compactMap { $0.date }.max() ?? Date()
        defaultData.minDate = defaultData.funkoList.compactMap { $0.date }.min() ?? Date()
    }
    
    private func setupDefaultType() {
        defaultData.typeList = Array(Set(defaultData.funkoList.compactMap { $0.type }))
    }
    
    private func setupFilteredData() {
        filteredData = defaultData
        filteredData.typeList = []
    }
    
    private func filter() {
        let minPrice: Double = filteredData.minPrice
        let maxPrice: Double = filteredData.maxPrice
        
        let minDate: Date = filteredData.minDate
        let maxDate: Date = filteredData.maxDate
        
        let types: [Funko.FunkoType] = filteredData.typeList
        
        filteredData.funkoList = defaultData.funkoList.filter {
            guard let price = $0.price,
                  let date = $0.date
            else { return false }
            
            let type = $0.type
            
            return price >= minPrice &&
            price <= maxPrice &&
            date >= minDate &&
            date <= maxDate &&
            (types.contains(type) || types.isEmpty)
        }
    }
}

extension FunkoListPresenter: FunkoDelegate {
    func sendData(data: KeyDataFunkos) {
        filteredData = data
        filter()
        view?.updateTableView()
    }
}

extension FunkoListPresenter: PresentadorFunkoListDelegate {
    
    func updateView() {
        view?.setupDefaultValue()
        view?.setupTableView()
    }
    
    func getDefaultValue() {
        repository.getFunkos(completion: { [self] funkos in
            self.setupDefaultValue(funkos: funkos)
            self.view?.showTableView()
            self.view?.updateTableView()
        })
    }
    
    func getNumberOfRows() -> Int {
        return filteredData.funkoList.count
    }
    
    func getCellData(index: Int) -> Funko {
        return filteredData.funkoList[index]
    }
    
    func backButtonAction() {
        view?.navigateToFilter(defaultData: defaultData, filteredData: filteredData)
    }
    
    func didSelectRowAt(index: Int) {
        view?.navigateToDetail(index: index)
    }
}
