//
//  FunkoListCell.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

class FunkoListCell: UITableViewCell, UINavigationBarDelegate {
    
    static let id: String = "FunkoListCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setupDataCell(_ funko: Funko) {
        guard let name = funko.name,
              let date = funko.date,
              let price = funko.price else {
            titleLabel.text = "funkoNotValid".localized
            subtitleLabel.isHidden = true
            priceLabel.isHidden = true
            return
        }
        
        titleLabel.text = name
        subtitleLabel.text = date.formatDate(format: Constants.Pattern.dateTextual)
        priceLabel.text = String(format: "priceWithUnit".localized, price)
    }
}
