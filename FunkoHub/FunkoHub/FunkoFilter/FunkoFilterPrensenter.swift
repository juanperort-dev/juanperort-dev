//
//  FilterPrensenter.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

protocol FunkoFilterViewControllerDelegate {
    func showMessageAlert()
    func changeTypeList()
    func sendFilteredData()
    func closeView()
    func resetCheckbox()
    func setupTypeCheckbox()
    func resetDateData()
    func resetPriceSliderData()
    func resetPriceSliderLabelData()
    func checkTypeCheckbox()
    func updateDate()
    func updatePriceSlider()
    func updatePriceSliderLabel()
    func changeMaxPriceLabel(price: Double)
}

class FunkoFilterPresenter: FunkoFilterPresenterDelegate {
    
    var view: FunkoFilterViewControllerDelegate?
    var defaultData: KeyDataFunkos = KeyDataFunkos()
    var changedData: KeyDataFunkos = KeyDataFunkos()
    
    private var roundedMaxPrice: Double = Constants.Numeric.priceMinValue
    
    func setView(_ delegate: FunkoFilterViewControllerDelegate) {
        view = delegate
    }
    
    func setupView() {
        view?.setupTypeCheckbox()
        view?.checkTypeCheckbox()
        updateView()
    }
    
    func updateView() {
        view?.updateDate()
        view?.updatePriceSlider()
        view?.updatePriceSliderLabel()
    }
    
    func selectFromDate(_ sender: Date) {
        changedData.minDate = sender
    }
    
    func selectToDate(_ sender: Date) {
        changedData.maxDate = sender
    }
    
    func updatePriceSlider(_ sliderValue: Double) {
        changedData.maxPrice = sliderValue
        roundedMaxPrice = round(changedData.maxPrice)
        
        view?.changeMaxPriceLabel(price: roundedMaxPrice)
    }
    
    func checkValues() {
        if isValidDate() {
            view?.changeTypeList()
            view?.sendFilteredData()
            view?.closeView()
        }
    }
    
    func isValidDate() -> Bool {
        guard changedData.minDate <= changedData.maxDate, changedData.maxDate <= Date() else {
            view?.showMessageAlert()
            return false
        }
        return true
    }
    
    func resetFilters() {
        setupTypeList()
        
        resetData()
        resetCheckbox()
        drawCheckbox()
        
        resetDateData()
        resetPriceSliderData()
        resetPriceSliderLabelData()
    }
    
    func setupTypeList() {
        changedData.typeList = []
    }
    
    func resetData() {
        changedData.minDate = defaultData.minDate
        changedData.maxDate = defaultData.maxDate
        
        changedData.maxPrice = defaultData.maxPrice
        changedData.minPrice = defaultData.minPrice
        
        changedData.typeList = defaultData.typeList
    }
    
    func resetCheckbox() {
        view?.resetCheckbox()
    }
    
    func drawCheckbox() {
        view?.setupTypeCheckbox()
    }
    
    func resetDateData() {
        view?.resetDateData()
    }
    
    func resetPriceSliderData() {
        view?.resetPriceSliderData()
    }
    
    func resetPriceSliderLabelData() {
        view?.resetPriceSliderLabelData()
    }
    
    func closeView() {
        view?.closeView()
    }
    
    func updateMaxPrice(_ maxPrice: Double) {
        setChangedMaxPrice(maxPrice)
        setRoundedMaxPrice()
    }
    
    func addType(_ isSelected: Bool, _ type: Funko.FunkoType) {
        if isSelected {
            addChangedTypeList(type)
        } else {
            deleteChangedTypeList(type)
        }
    }
    
    func addChangedTypeList(_ type: Funko.FunkoType) {
        if !changedData.typeList.contains(type) {
            changedData.typeList.append(type)
        }
    }
    
    func deleteChangedTypeList(_ type: Funko.FunkoType) {
        if let index = changedData.typeList.firstIndex(of: type) {
            changedData.typeList.remove(at: index)
        }
    }
    
    func setDefaultData(_ data: KeyDataFunkos) {
        defaultData = data
    }
    
    func getDefaultData() -> KeyDataFunkos {
        return defaultData
    }
    
    func setChangedData(_ data: KeyDataFunkos) {
        changedData = data
    }
    
    func getChangedData() -> KeyDataFunkos {
        return changedData
    }
    
    func getDefaultMinDate() -> Date {
        return defaultData.minDate
    }
    
    func getChangedMinDate() -> Date {
        return changedData.minDate
    }
    
    func setChangedMinDate(_ date: Date) {
        changedData.minDate = date
    }
    
    func getDefaultMaxDate() -> Date {
        defaultData.maxDate
    }
    
    func getChangedMaxDate() -> Date {
        changedData.maxDate
    }
    
    func setChangedMaxDate(_ date: Date) {
        changedData.maxDate = date
    }
    
    func getChangedMinPrice() -> Double {
        return changedData.minPrice
    }
    
    func setChangedMinPrice(_ price: Double) {
        changedData.minPrice = price
    }
    
    func getDefaultMinPrice() -> Double {
        return defaultData.minPrice
    }
    
    func getDefaultMaxPrice() -> Double {
        return defaultData.maxPrice
    }
    
    func getChangedMaxPrice() -> Double {
        return changedData.maxPrice
    }
    
    func setChangedMaxPrice(_ price: Double) {
        changedData.maxPrice = price
    }
    
    func getRoundedMaxPrice() -> Double {
        return roundedMaxPrice
    }
    
    func setRoundedMaxPrice() {
        roundedMaxPrice = round(changedData.maxPrice)
    }
    
    func getDefaultTypeList() -> [Funko.FunkoType] {
        return defaultData.typeList
    }
    
    func getChangedTypeList() -> [Funko.FunkoType] {
        return changedData.typeList
    }
}


