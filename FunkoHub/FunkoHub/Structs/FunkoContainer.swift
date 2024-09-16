//
//  FunkoContainer.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

struct FunkoContainer: Codable {
    let numFunkos: Int
    var funkos: [Funko]? = []
}
