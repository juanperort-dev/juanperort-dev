//
//  FunkoCollection.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation

struct FunkoCollection: Decodable {
    var name: String
    var code: String
}

enum TypeCodeFunko: String {
    case OP, DS, AOT, DB, NRT
    
    func getImageName() -> String {
        switch self {
        case .OP:
            return "One Piece"
        case .DS:
            return "Demon Slayer"
        case .AOT:
            return "Attack on Titan"
        case .DB:
            return "Dragon Ball"
        case .NRT:
            return "Naruto"
        }
    }
    
    static func fromFullName(name: String) -> TypeCodeFunko? {
        switch name {
        case "One Piece":
            return .OP
        case "Demon Slayer":
            return .DS
        case "Attack on Titan":
            return .AOT
        case "Dragon Ball":
            return .DB
        case "Naruto":
            return .NRT
        default:
            return nil
        }
    }
}
