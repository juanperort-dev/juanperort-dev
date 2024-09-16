//
//  CallsAlomofire.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import Alamofire

class CallsAlamofire {
    
    func getFunkos(completion: @escaping ([Funko]) -> Void) {
        AF.request(Constants.url.funkoList, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                self.manageSuccessFunkos(data: data, completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getFunkoCollection(completion: @escaping ([FunkoCollection]) -> Void) {
        AF.request(Constants.url.funkoCollection, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                self.manageSuccessFunkoData(data: data, completion: completion)
            case .failure(_):
                showAlert(title: "alert.title.errorService".localized,
                          message: "alert.message.errorService".localized,
                          messageButton: "alert.button.errorService".localized,
                          viewcontroller: DashboardViewController())
            }
        }
    }
    
    func manageSuccessFunkos(data: Data?, completion: @escaping ([Funko]) -> Void) {
        do {
            let decoder = JSONDecoder()
            guard let data = data else{return}
            let dataJSON = try decoder.decode(FunkoContainer.self, from: data)
            let funkos = dataJSON.funkos ?? []
            completion(funkos)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func manageSuccessFunkoData(data: Data?, completion: @escaping ([FunkoCollection]) -> Void) {
        do {
            let decoder = JSONDecoder()
            guard let data = data else{return}
            let dataJSON = try decoder.decode([FunkoCollection].self, from: data)
            let funkoCollection = dataJSON
            completion(funkoCollection)
          
        } catch {
            showAlert(title: "alert.title.errorService".localized,
                      message: "alert.message.dataLoadFailure".localized,
                      messageButton: "alert.button.errorService".localized,
                      viewcontroller: DashboardViewController())
        }
    }
    
}
