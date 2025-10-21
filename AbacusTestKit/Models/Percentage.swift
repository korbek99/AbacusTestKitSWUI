//
//  Percentage.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 23-07-25.
//


import Foundation

struct Percentage: Codable {
    let price: String
    let returnAmount: String
    let returnPercentage: String

    enum CodingKeys: String, CodingKey {
        case price
        case returnAmount = "return_amount"
        case returnPercentage = "return_percentage"
    }
}

