//
//  TradeViewModel.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//
import Foundation

class TradeViewModel: ObservableObject {
    
   
    
    @Published var items: [CurrencyList] = []
    private let webService = webServicesItems()
    
    init(currency: String) {
        loadItems(currency: currency)
    }

    func loadItems(currency: String) {
        webService.getPortafolio(for: currency) { [weak self] result in
            DispatchQueue.main.async {
                self?.items = result ?? []
            }
        }
    }
}


