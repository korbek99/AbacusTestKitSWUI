//
//  CashBalanceViewModel.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//


import Foundation

class CashBalanceViewModel: ObservableObject {
    @Published var usdToday: Double = 0.0
    @Published var clpToday: Double = 0.0
    @Published var items: [CashMoney] = []
    private let webService = webServicesItems()
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        webService.getCashCurrency { [weak self] result in
            DispatchQueue.main.async {
                if let items = result {
                    self?.items = items
                    self?.setCurrencyToday()
                } else {
                    print("No se pudo cargar la lista de CashMoney")
                }
            }
        }
    }
    
    func setCurrencyToday() {
        for item in items {
            if item.codigo == "USD", let value = Double(item.currency) {
                usdToday = value
                print("💵 USD Today actualizado: \(usdToday)")
               
            } 
            else {
                if item.codigo == "CLP", let value = Double(item.currency) {
                    clpToday = value
                    print("💵 CLP Today actualizado: \(clpToday)")
                    
                }
            }
        }
    }

}




//import Foundation
//class CashBalanceViewModel: ObservableObject {
//    
//    @Published var items: [CashMoney] = []
//
//    private let webService = webServicesItems() 
//    
//  
//    
//    func loaditems(){
//        
//        let jsonString = """
//                [
//                    { "codigo": "USD", "name": "USD DOLLARS", "currency": "40.455,21" },
//                    { "codigo": "CLP", "name": "PESO CHILENO", "currency": "42.788,54" }
//                ]
//                """
//        
//        if let data = jsonString.data(using: .utf8) {
//            do {
//                let decodedStocks = try JSONDecoder().decode([CashMoney].self, from: data)
//                self.items = decodedStocks
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
//        }
//        
//    }
//}
