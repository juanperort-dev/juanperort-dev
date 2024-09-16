//
//  Funko.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

struct Funko: Codable, Equatable {
    var name: String?
    var type: FunkoType
    var price: Double?
    var date: Date?
    
    enum FunkoType: String, CaseIterable, Codable {
        case OP = "OP"
        case DS = "DS"
        case AOT = "AOT"
        case DB = "DB"
        case NRT = "NRT"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case type
        case price
        case date
    }
    
    init(name: String, type: FunkoType, price: Double?, date: Date?) {
        self.name = name
        self.type = type
        self.price = price
        self.date = date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(FunkoType.self, forKey: .type)
        price = try container.decodeIfPresent(Double.self, forKey: .price)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Pattern.date
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
            if let date = dateFormatter.date(from: dateString) {
                self.date = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "invalidDate".localized)
            }
        } else {
            self.date = nil
        }
    }
    
    static func == (lhs: Funko, rhs: Funko) -> Bool {
        return lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.price == rhs.price &&
        lhs.date == rhs.date
    }
}

