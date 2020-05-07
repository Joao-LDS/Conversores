//
//  ConversoresAPI.swift
//  Conversores
//
//  Created by João Luis dos Santos on 24/04/20.
//  Copyright © 2020 João Luis dos Santos. All rights reserved.
//

import UIKit
import Alamofire

class ConversoresAPI: NSObject {

    // MARK: - GET
    
    func recoverDolarValue(dolar:@escaping(_ dolar: Double) -> Void) {
        
        // Requisição HTTP
        AF.request("https://economia.awesomeapi.com.br/all/USD-BRL").responseJSON { (response) in
            switch response.result {
            case .success(let value): // value é o que vem dentro do json
                print(value)
                if let JSON = value as? [String: Any] {
                    guard let usd = JSON["USD"] as? Dictionary<String, Any> else { return }
                    guard let ask = usd["bid"] as? String else  { return }
                    guard let dolarValue = Double(ask) else { return }
                    print(dolarValue)
                    dolar(dolarValue) // Passa o valor para a clojure
                    break
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
