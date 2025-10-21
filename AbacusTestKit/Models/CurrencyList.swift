//
//  CurrencyList.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation
struct CurrencyList: Identifiable, Decodable {
    var id: String { ticker }
    let ticker: String
    let name, price, quantity: String
    let value, weight: String
}
