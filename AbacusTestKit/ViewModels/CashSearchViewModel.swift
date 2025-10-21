//
//  CashSearchViewModel.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 23-07-25.
//

import Foundation
import Combine
class CashSearchViewModel: ObservableObject {
    
    @Published var items: [FolioList] = []
    private let webService = webServicesItems()
    @Published var percentageData: [String: (amount: Double, percentage: Double)] = [:]
    private var cancellables = Set<AnyCancellable>()
    
    init(strtext: String,currency: String) {
        loadItems(strtext: strtext)
        loadPercentageData(ticker: strtext, currency: currency)
    }
    
    func loadItems(strtext: String) {
        webService.getfolioSearchNew(for: strtext) { [weak self] result in
            DispatchQueue.main.async {
                if let items = result {
                    self?.items = items
                } else {
                    print("No se pudo cargar la lista de CashMoney")
                }
            }
        }
    }
    
    private func loadPercentageData(ticker: String, currency: String) {
           PercentageViewModel(strticker: ticker, strcurr: currency).$items
               .sink { [weak self] items in
                   guard let self = self, !items.isEmpty else { return }
                   
                   let amount = items.compactMap { Double($0.returnAmount) }.first ?? 0.0
                   let percentage = items.compactMap { Double($0.returnPercentage) }.first ?? 0.0
                   
                   DispatchQueue.main.async {
                       self.percentageData[ticker] = (amount, percentage)
                   }
               }
               .store(in: &cancellables)
   }
       
   func getPercentageInfo(ticker: String, currency: String) -> (amount: Double, percentage: Double) {
       return percentageData[ticker] ?? (0.0, 0.0)
   }
}
