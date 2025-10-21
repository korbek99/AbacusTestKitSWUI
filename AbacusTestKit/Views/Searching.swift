//
//  Searching.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//
import SwiftUI

struct Searching: View {
    
    @StateObject private var viewModel = SearchViewModel()

    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                List(viewModel.items.filter {
                    searchText.isEmpty ? true :
                    $0.ticker.localizedCaseInsensitiveContains(searchText) ||
                    $0.name.localizedCaseInsensitiveContains(searchText)
                }) { items in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(items.ticker)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("$ \(formatValue(Double(items.value)!))")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Text(items.name)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.black)
                }
                .listStyle(PlainListStyle())
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Buscar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
   
}

#Preview {
    Searching()
}
