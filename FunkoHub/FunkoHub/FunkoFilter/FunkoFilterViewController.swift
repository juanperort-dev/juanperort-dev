//
//  FunkoFilterViewController.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

protocol FunkoFilterPresenterDelegate {
    func setupView()
    func selectFromDate(_ sender: Date)
    func selectToDate(_ sender: Date)
    func updatePriceSlider(_ sliderValue: Double)
    func checkValues()
    func resetFilters()
    func closeView()
    func addType(_ isSelected: Bool, _ type: Funko.FunkoType)
    
    func setDefaultData(_ data: KeyDataFunkos)
    func getDefaultData() -> KeyDataFunkos
    func setChangedData(_ data: KeyDataFunkos)
    func getChangedData() -> KeyDataFunkos
    func getDefaultMinDate() -> Date
    func getChangedMinDate() -> Date
    func getDefaultMaxDate() -> Date
    func getChangedMaxDate() -> Date
    func getDefaultMinPrice() -> Double
    func getChangedMinPrice() -> Double
    func getDefaultMaxPrice() -> Double
    func getChangedMaxPrice() -> Double
    func getDefaultTypeList() -> [Funko.FunkoType]
    func getChangedTypeList() -> [Funko.FunkoType]
    
    func setView(_ delegate: FunkoFilterViewControllerDelegate)
}

class FunkoFilterViewController: UIViewController, FunkoFilterViewControllerDelegate {
    
    weak var delegate: FunkoDelegate?
    var presenter: FunkoFilterPresenterDelegate = FunkoFilterPresenter()
    
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var selectedMinPriceLabel: UILabel!
    @IBOutlet weak var selectedMaxPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var typesStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        presenter.view = self
        presenter.setView(self)
        presenter.setupView()
    }
    
    @IBAction func fromDatePickerAction(_ sender: Any) {
        guard let datePicker = sender as? UIDatePicker else { return }
        presenter.selectFromDate(datePicker.date)
    }
    
    @IBAction func toDatePickerAction(_ sender: Any) {
        guard let datePicker = sender as? UIDatePicker else { return }
        presenter.selectToDate(datePicker.date)
    }
    
    @IBAction func priceSliderAction(_ sender: Any) {
        guard let slider = sender as? UISlider else { return }
        presenter.updatePriceSlider(Double(slider.value))
    }
    
    @IBAction func applyButtonAction(_ sender: Any) {
        presenter.checkValues()
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        presenter.resetFilters()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        presenter.closeView()
    }
    
    func setupTypeCheckbox() {
        presenter.getDefaultTypeList().forEach({ type in
            let customView = CheckboxView()
            typesStackView.addArrangedSubview(customView)
            customView.typeLabel.text = TypeCodeFunko(rawValue: type.rawValue)?.getImageName()
        })
    }
    
    func checkTypeCheckbox() {
        typesStackView.subviews.forEach({ subview in
            if let checkboxView = subview as? CheckboxView,
               let actualType = TypeCodeFunko.fromFullName(name: checkboxView.typeLabel.text ?? .empty)?.rawValue,
               let newType = Funko.FunkoType(rawValue: actualType),
               presenter.getChangedTypeList().contains(newType) {
                checkboxView.isSelected = true
                checkboxView.changeImageButton()
            }
        })
    }
    
    func updateDate() {
        fromDatePicker.date = presenter.getChangedMinDate()
        toDatePicker.date = presenter.getChangedMaxDate()
    }
    
    func updatePriceSlider() {
        priceSlider.minimumValue = Float(presenter.getChangedMinPrice())
        priceSlider.maximumValue = Float(presenter.getDefaultMaxPrice())
        priceSlider.value = Float(presenter.getChangedMaxPrice())
        priceSlider.addTarget(self, action: #selector(priceSliderAction(_:)), for: .valueChanged)
    }
    
    func updatePriceSliderLabel() {
        minPriceLabel.text = String(presenter.getChangedMinPrice())
        selectedMinPriceLabel.text = String(presenter.getChangedMinPrice())
        selectedMaxPriceLabel.text = String(round(presenter.getChangedMaxPrice()))
        maxPriceLabel.text = String(presenter.getDefaultMaxPrice())
    }
    
    func changeMaxPriceLabel(price: Double) {
        selectedMaxPriceLabel.text = String(price)
    }
    
    func showMessageAlert() {
        showAlert(title: "alert.invalidDate".localized,
                  message: "alert.message.invalidDate".localized,
                  messageButton: "alert.button.invalidDate".localized,
                  viewcontroller: self)
    }
    
    func changeTypeList() {
        typesStackView.subviews.forEach({ subview in
            guard let checkboxView = subview as? CheckboxView,
                  let actualType = TypeCodeFunko.fromFullName(name: checkboxView.typeLabel.text ?? .empty)?.rawValue,
                  let newType = Funko.FunkoType(rawValue: actualType)
            else {return}
            
            addType(checkboxView: checkboxView, newType: newType)
        })
    }
    
    func addType(checkboxView: CheckboxView, newType: Funko.FunkoType) {
        presenter.addType(checkboxView.isSelected, newType)
    }
    
    func sendFilteredData() {
        delegate?.sendData(data: presenter.getChangedData())
    }
    
    func closeView() {
        navigationController?.popViewController(animated: true)
    }
    
    func resetCheckbox() {
        for subview in typesStackView.arrangedSubviews {
            if subview is CheckboxView {
                typesStackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    }
    
    func resetDateData() {
        fromDatePicker.date = presenter.getDefaultMinDate()
        toDatePicker.date = presenter.getDefaultMaxDate()
    }
    
    func resetPriceSliderData() {
        priceSlider.value = Float(presenter.getDefaultMaxPrice())
        priceSlider.maximumValue = Float(presenter.getDefaultMaxPrice())
        priceSlider.minimumValue = Float(presenter.getDefaultMinPrice())
    }
    
    func resetPriceSliderLabelData() {
        maxPriceLabel.text = String(presenter.getDefaultMaxPrice())
        minPriceLabel.text = String(presenter.getDefaultMinPrice())
        selectedMaxPriceLabel.text = String(presenter.getDefaultMaxPrice())
    }
}
