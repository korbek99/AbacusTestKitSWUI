//
//  UtilsFormats.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation
func formatValue(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
}
