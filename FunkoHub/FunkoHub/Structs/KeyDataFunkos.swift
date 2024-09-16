//
//  KeyDataFunkos.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

struct KeyDataFunkos: Equatable {
    var minPrice: Double = 0.0
    var maxPrice: Double = 0.0
    var minDate: Date = Date()
    var maxDate: Date = Date()
    var typeList: [Funko.FunkoType] = []
    var funkoList: [Funko] = []

    static func ==(lhs: KeyDataFunkos, rhs: KeyDataFunkos) -> Bool {
        return lhs.minPrice == rhs.minPrice &&
            lhs.maxPrice == rhs.maxPrice &&
            lhs.minDate == rhs.minDate &&
            lhs.maxDate == rhs.maxDate &&
            lhs.typeList == rhs.typeList &&
            lhs.funkoList == rhs.funkoList
    }
}
