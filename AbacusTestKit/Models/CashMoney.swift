//
//  CashMoney.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation
struct CashMoney: Identifiable, Decodable {
    var id: String { codigo }
    let codigo: String
    let name: String
    let currency: String
}
