//
//  GraphicsViewModel.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 24-07-25.
//
import Foundation

struct PeriodDatas: Identifiable {
    var id = UUID()
    var period: String
    var sales: Int
}

class GraphicsViewModel: ObservableObject {
   
    @Published private var oneDayTotal: Double = 0.0
    @Published private var oneWeekTotal: Double = 0.0
    @Published private var oneMonthTotal: Double = 0.0
    @Published private var threeMonthTotal: Double = 0.0
    @Published private var oneYearTotal: Double = 0.0
    @Published private var fiveYearTotal: Double = 0.0
    @Published private var ytdTotal: Double = 0.0
    
  
    @Published var dataGraph: [PeriodDatas] = []
    @Published var items: [GraphicCurrency] = [] {
        didSet {
    
            setTotalGraphics()
        }
    }
    
    private let webService = webServicesItems()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(currency: String) {
        loadItems(currency: currency)
    }

    func loadItems(currency: String) {
        webService.getGraphicsCurrency(for: currency) { [weak self] result in
            DispatchQueue.main.async {
                self?.items = result ?? []
                print("Datos cargados: \(self?.items.count ?? 0) elementos")
            }
        }
    }
    
    func setTotalGraphics() {
       
        guard !items.isEmpty else {
            print("No hay datos para procesar")
            dataGraph = []
            return
        }
        
        let targetDateString = dateFormatter.string(from: Date())
        print("Fecha objetivo: \(targetDateString)")
        
        guard let targetDate = dateFormatter.date(from: targetDateString) else {
            print("Fecha inválida")
            return
        }
        
        guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: targetDate),
              let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -29, to: targetDate),
              let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: targetDate),
              let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: targetDate),
              let fiveYearsAgo = Calendar.current.date(byAdding: .year, value: -5, to: targetDate),
              let tenYearsAgo = Calendar.current.date(byAdding: .year, value: -10, to: targetDate) else {
            print("Error calculando fechas de referencia")
            return
        }
        

        func filterItems(from startDate: Date, to endDate: Date) -> [GraphicCurrency] {
            return items.filter {
                guard let date = dateFormatter.date(from: $0.date) else { return false }
                return date >= startDate && date <= endDate
            }
        }

        oneDayTotal = calculateTotal(for: targetDateString)
        oneWeekTotal = calculateTotal(for: filterItems(from: sevenDaysAgo, to: targetDate))
        oneMonthTotal = calculateTotal(for: filterItems(from: thirtyDaysAgo, to: targetDate))
        threeMonthTotal = calculateTotal(for: filterItems(from: threeMonthsAgo, to: targetDate))
        oneYearTotal = calculateTotal(for: filterItems(from: oneYearAgo, to: targetDate))
        fiveYearTotal = calculateTotal(for: filterItems(from: fiveYearsAgo, to: targetDate))
        ytdTotal = calculateTotal(for: filterItems(from: tenYearsAgo, to: targetDate))
        
        
        print("""
        Totales calculados:
        1D: \(oneDayTotal)
        1W: \(oneWeekTotal)
        1M: \(oneMonthTotal)
        3M: \(threeMonthTotal)
        1Y: \(oneYearTotal)
        5Y: \(fiveYearTotal)
        YTD: \(ytdTotal)
        """)
        
        
        dataGraph = [
            PeriodDatas(period: "1D", sales: Int(oneDayTotal)),
            PeriodDatas(period: "1W", sales: Int(oneWeekTotal)),
            PeriodDatas(period: "1M", sales: Int(oneMonthTotal)),
            PeriodDatas(period: "3M", sales: Int(threeMonthTotal)),
            PeriodDatas(period: "1Y", sales: Int(oneYearTotal)),
            PeriodDatas(period: "5Y", sales: Int(fiveYearTotal)),
            PeriodDatas(period: "YTD", sales: Int(ytdTotal))
        ]
    }
    
    private func calculateTotal(for dateString: String) -> Double {
        return items
            .filter { $0.date == dateString }
            .compactMap { Double($0.value) }
            .reduce(0, +)
    }
    
    private func calculateTotal(for items: [GraphicCurrency]) -> Double {
        return items
            .compactMap { Double($0.value) }
            .reduce(0, +)
    }
}
