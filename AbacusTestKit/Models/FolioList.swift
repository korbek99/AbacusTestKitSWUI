//
//  FolioList.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation
struct FolioList: Identifiable, Decodable {
    var id: String { ticker } 
    let ticker: String
    let name: String
    let currency: String
    let is_favorite: Bool
    let fractionable: Bool
}
