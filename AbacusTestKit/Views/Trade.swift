//
//  Trade.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//
import SwiftUI
import Charts

struct Trade: View {
    @State private var selectedCurrency: String = NSLocalizedString("TRADE_USD", comment: "Error Text")
    @State  var isPositionsVisible = true
    @StateObject private var viewModelCash = CashBalanceViewModel()
    @StateObject private var viewModelList = TradeViewModel(currency: NSLocalizedString("TRADE_USD", comment: "Error Text"))
    @StateObject private var viewModelGraphics = GraphicsViewModel(currency: NSLocalizedString("TRADE_USD", comment: "Error Text"))
    
    var body: some View {
        NavigationView {
            List {
                chartSection
                purchasingPowerSection
                positionsSection
            }
            .background(Color.black)
            .scrollContentBackground(.hidden)
            .navigationTitle("Patrimonio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { currencyToolbarItems }
            .onChange(of: selectedCurrency) { handleCurrencyChange(newCurrency: $0) }
        }
        .background(Color.black)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Componentes de la Vista
    
    private var chartSection: some View {
        Section {
            Chart(viewModelGraphics.dataGraph) { item in
                LineMark(
                    x: .value("Periodo", item.period),
                    y: .value("Ventas", item.sales)
                )
                .foregroundStyle(.blue)
                .interpolationMethod(.catmullRom)
            }
            .chartXAxis { xAxis }
            .chartYAxis { yAxis }
            .frame(height: 300)
            .padding()
            .background(Color.black)
        }  header: {
            VStack(alignment: .center, spacing: 4) {
                Text("\(selectedCurrency): \(selectedCurrency == "USD" ? viewModelCash.usdToday : viewModelCash.clpToday, specifier: "%.2f")")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text("$7.06 (0.04%) Hoy")
                    .foregroundColor(.green)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
        }
        .listRowBackground(Color.black)
    }
    
    private var xAxis: some AxisContent {
        AxisMarks(preset: .aligned) { _ in
            AxisGridLine()
            AxisTick()
            AxisValueLabel()
                .foregroundStyle(.white)
        }
    }
    
    private var yAxis: some AxisContent {
        AxisMarks(preset: .extended) { _ in
            AxisGridLine()
            AxisTick()
            AxisValueLabel()
                .foregroundStyle(.white)
        }
    }
    
    private var purchasingPowerSection: some View {
        Section(header: Text("Poder de Compra").foregroundColor(.white)) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModelCash.items) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(item.currency)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .listRowBackground(Color.black)
    }
    private var positionsSection: some View {
    
        return Section(header:
            HStack {
                Text("Posiciones")
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isPositionsVisible.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        Text("Valor del día")
                            .foregroundColor(.white)
                            .font(.subheadline)
                        
                        Image(systemName: isPositionsVisible ? "chevron.down" : "chevron.up")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                }
            }
            .padding(.vertical, 8)
        ) {
            if isPositionsVisible {
                ForEach(viewModelList.items.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(viewModelList.items[index].ticker)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text(formattedValue(index: index))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        Text(viewModelList.items[index].name)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 8)
                        
                        if index < viewModelList.items.count - 1 {
                            Divider().background(Color.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .listRowBackground(Color.black)
    }
    
    private var currencyToolbarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button("USD") {
                selectedCurrency = "USD"
            }
            .foregroundColor(selectedCurrency == "USD" ? .blue : .white)
            
            Button("CLP") {
                selectedCurrency = "CLP"
            }
            .foregroundColor(selectedCurrency == "CLP" ? .blue : .white)
        }
    }
    
    // MARK: - Funciones de Ayuda
    
    private func formattedValue(index: Int) -> String {
        guard let value = Double(viewModelList.items[index].value) else {
            return "$0.00"
        }
        return String(format: "$%.2f", value)
    }
    
    private func handleCurrencyChange(newCurrency: String) {
        viewModelList.loadItems(currency: newCurrency)
        viewModelGraphics.loadItems(currency: newCurrency)
    }
}

#Preview {
    Trade()
}
