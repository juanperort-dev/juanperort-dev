//
//  FunkoRepository.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

protocol FunkoRepository {
    func getFunkos(completion: @escaping ([Funko]) -> Void)
    func getFunkoCollection(completion: @escaping ([FunkoCollection]) -> Void)
}
