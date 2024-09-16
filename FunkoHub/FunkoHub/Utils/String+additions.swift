//
//  String+additions.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

extension String {
    public static var empty: String {
        return ""
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
