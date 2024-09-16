//
//  Extensions.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

extension Date {
    func formatDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  format
        dateFormatter.locale = Locale(identifier: Constants.Locale.spanish)
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate.capitalized
    }
    
}
