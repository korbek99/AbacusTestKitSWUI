//
//  PercentageViewModel.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 23-07-25.
//

import Foundation


class PercentageViewModel: ObservableObject {
    
    @Published var items: [Percentage] = []
    private let webService = webServicesItems()
    
    init(strticker: String,strcurr: String) {
        loadItems(strticker: strticker,strcurr: strcurr)
    }
    
    func loadItems(strticker: String,strcurr: String) {
        webService.getPercentageTicker(for: strticker, for: strcurr) { [weak self] result in
            DispatchQueue.main.async {
                if let items = result {
                    self?.items = items
                } else {
                    print("No se pudo cargar la lista de Percentage")
                }
            }
        }
    }

}
