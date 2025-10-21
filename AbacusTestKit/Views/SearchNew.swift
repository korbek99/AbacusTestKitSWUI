//
//  SearchNew.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 23-07-25.
//
import SwiftUI

struct SearchNew: View {
    
    @StateObject private var viewModel = CashSearchViewModel(strtext: "a", currency:  NSLocalizedString("TRADE_USD", comment: "Error Text"))
   
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: searchText) { newValue in
                        let query = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                        viewModel.loadItems(strtext: query.isEmpty ? "a" : query)
                    }
                
                List(viewModel.items) { item in
                    let percentageInfo = viewModel.getPercentageInfo(ticker: item.ticker, currency: NSLocalizedString("TRADE_USD", comment: "Error Text"))
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text(item.ticker)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                           
                                                .foregroundColor(.yellow)
                            Text("\(percentageInfo.percentage)")
                         
                            Image(systemName: "star.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Text(item.name)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.black)
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle(NSLocalizedString("SEARCH", comment: "Error Text"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

#Preview {
    SearchNew()
}
