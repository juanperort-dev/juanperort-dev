//
//  Mock.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

import Foundation
import OHHTTPStubs

class Mock: NSObject {
    
    static let shared = Mock()
    
    @objc class func config() {
        loadMocks()
    }

    static func loadMocks() {
        Mock.shared.loadFunko()
    }
    
    func loadFunko() {
        addStub(path: "/funkoCollection", status: 200, file: "funkoCollection.json")
        addStub(path: "/funkos", status: 200, file: "funkos.json")
        addStub(path: "/invoicesDetail", status: 200, file: "detail.json")
    }
    
    func addStub(path: String, status: Int32, file: String) {

        stub(condition:  pathEndsWith(path)) { _ in
            if let stubPath = OHPathForFile(file, type(of: self)) {
                return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
            } else {
//                let stubData = "Json mock not found".data(using: .utf8)
                return fixture(filePath: file, headers: ["Content-Type":"application/json"])
            }
        }
        
    }
    
}
