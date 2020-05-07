//
//  Calculate.swift
//  Conversores
//
//  Created by João Luis dos Santos on 24/04/20.
//  Copyright © 2020 João Luis dos Santos. All rights reserved.
//

import UIKit

class Calculate: NSObject {
    
    func celsius(_ value: Double) -> Double {
        let res = (value - 32) * 5/9
        return res
    }

    func fahrenheit(_ value: Double) -> Double {
        let res = (value * (9/5)) + 32
        return res
    }

    func quilograma(_ value: Double) -> Double {
        let res = value * 2.205
        return res
    }

    func libra(_ value: Double) -> Double {
        let res = value / 2.205
        return res
    }
    
    func dolar(_ bid: Double,_ value: Double) -> Double {
        let res = bid * value
        return res
    }
    
    func real(_ bid: Double,_ value: Double) -> Double {
        let res = value / bid
        return res
    }

    func quilometro(_ value: Double) -> Double {
        let res = value / 1.609
        return res
    }

    func milha(_ value: Double) -> Double {
        let res = value * 1.609
        return res
    }
    
}
