//
//  Constants.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

struct Constants {
    struct Pattern {
        static let date = "dd/MM/yyyy"
        static let dateTextual = "dd MMM yyyy"
    }
    
    struct Numeric {
        static let priceMinValue = 0.0
        static let priceMaxValue = 1.0e20
    }
    
    struct url {
        static let funkoCollection = "https://viewnext.com/funkoCollection"
        static let funkoList = "https://viewnext.com/funkos"
        static let Detallefactura = "https://viewnext.com/invoicesDetail"
    }
    
    struct Storyboard {
        static let funkoList = "FunkoList"
        static let funkoFilter = "FunkoFilter"
        static let funkoDetail = "StoryboardDetalle"
        
        static let checkboxView = "CheckboxView"
    }
    
    struct Image {
        static let selectedCheckbox = "checkmark.square"
        static let unselectedCheckbox = "square"
    }
    
    struct Locale {
        static let spanish = "es_ES"
    }
}
