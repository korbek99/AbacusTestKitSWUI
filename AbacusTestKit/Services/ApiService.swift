//
//  ApiService.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation
import UIKit

class webServicesItems {
    var urlbase: String = ""
    var utils = UtilServices()
    
    private var apiKey = ""
    
    func getPortafolio(for currency: String, completion: @escaping ([CurrencyList]?) -> ()) {
        
        guard let endpointData = utils.getEndpoint(fromName: "totalVaueListPortafolio") else {
            print("Error: No se pudo obtener el endpoint.")
            return
        }
        apiKey = endpointData.APIKey
        print(endpointData.APIKey)
        print(endpointData.url)
        
        guard let url = URL(string: endpointData.url.absoluteString + currency) else {
            print("Error: URL no válida.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No se recibieron datos.")
                completion(nil)
                return
            }
            do {
                let petsList = try JSONDecoder().decode([CurrencyList].self, from: data)
                let allBreeds = petsList
                
                print("Breeds recibidos: \(allBreeds)")
                completion(allBreeds)
            } catch {
                print("Error al decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func getCashCurrency(completion: @escaping ([CashMoney]?) -> ()) {
        
        guard let endpointData = utils.getEndpoint(fromName: "totalVaueBalance") else {
            print("Error: No se pudo obtener el endpoint.")
            return
        }
        apiKey = endpointData.APIKey
        print(endpointData.APIKey)
        print(endpointData.url)
        
        guard let url = URL(string: endpointData.url.absoluteString) else {
            print("Error: URL no válida.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No se recibieron datos.")
                completion(nil)
                return
            }
            do {
                let decodedDict = try JSONDecoder().decode([String: Double].self, from: data)
                
                let items = decodedDict.map { (key, value) in
                    CashMoney(codigo: key, name: key == "USD" ? "USD DOLLARS" : "PESO CHILENO", currency: "\(value)")
                }
                
                print("Items decodificados: \(items)")
                completion(items)
            } catch {
                print("Error al decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    
    
    func getPortafolioSearch(for valor : String, completion: @escaping ([CurrencyList]?) -> ()) {
        
        guard let endpointData = utils.getEndpoint(fromName: "totalVaueListPortafolio") else {
            print("Error: No se pudo obtener el endpoint.")
            return
        }
        apiKey = endpointData.APIKey
        print(endpointData.APIKey)
        print(endpointData.url)
        
        guard let url = URL(string: endpointData.url.absoluteString + valor) else {
            print("Error: URL no válida.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No se recibieron datos.")
                completion(nil)
                return
            }
            do {
                let petsList = try JSONDecoder().decode([CurrencyList].self, from: data)
                let allBreeds = petsList
                
                print("Breeds recibidos: \(allBreeds)")
                completion(allBreeds)
            } catch {
                print("Error al decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func getfolioSearchNew(for valor : String, completion: @escaping ([FolioList]?) -> ()) {
        
        guard let endpointData = utils.getEndpoint(fromName: "totalVaueSearch") else {
            print("Error: No se pudo obtener el endpoint.")
            return
        }
        apiKey = endpointData.APIKey
        print(endpointData.APIKey)
        print(endpointData.url)
        
        guard let url = URL(string: endpointData.url.absoluteString + valor) else {
            print("Error: URL no válida.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No se recibieron datos.")
                completion(nil)
                return
            }
            do {
                let petsList = try JSONDecoder().decode([FolioList].self, from: data)
                let allBreeds = petsList
                
                print("Breeds recibidos: \(allBreeds)")
                completion(allBreeds)
            } catch {
                print("Error al decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
        
        
    }
    func getPercentageTicker(for valor: String, for curr: String, completion: @escaping ([Percentage]?) -> ()) {
        var strurlend: String = "/market-data/?currency="
        var strDefault: String = ""
        
        guard let endpointData = utils.getEndpoint(fromName: "getVauePercentage") else {
            print("Error: No se pudo obtener el endpoint.")
            completion(nil)
            return
        }
        
        apiKey = endpointData.APIKey
        print("🔑 API Key: \(apiKey)")
        print("🌐 Endpoint base: \(endpointData.url)")
        
        strDefault = valor.isEmpty ? "a" : valor
        
        guard let url = URL(string: endpointData.url.absoluteString + strDefault + strurlend + curr) else {
            print("Error: URL no válida.")
            completion(nil)
            return
        }
        
        print("🌐 Endpoint Final: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error en la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("❌ Error: No se recibieron datos.")
                completion(nil)
                return
            }
            
            do {
                let percentage = try JSONDecoder().decode(Percentage.self, from: data)
                print("✅ Percentage recibido: \(percentage)")
                completion([percentage])
            } catch {
                print("❌ Error al decodificar JSON: \(error.localizedDescription)")
                print("🔍 Datos crudos: \(String(data: data, encoding: .utf8) ?? "No se pudo mostrar el JSON")")
                completion(nil)
            }
        }.resume()
    }

    
    func getGraphicsCurrency(for valor : String, completion: @escaping ([GraphicCurrency]?) -> ()){
        
        guard let endpointData = utils.getEndpoint(fromName: "getGraphicCurrency") else {
            print("Error: No se pudo obtener el endpoint.")
            return
        }
        apiKey = endpointData.APIKey
        print(endpointData.APIKey)
        print(endpointData.url)
        
        guard let url = URL(string: endpointData.url.absoluteString + valor) else {
            print("Error: URL no válida.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No se recibieron datos.")
                completion(nil)
                return
            }
            do {
                let petsList = try JSONDecoder().decode([GraphicCurrency].self, from: data)
                let allBreeds = petsList
                
                print("Breeds recibidos: \(allBreeds)")
                completion(allBreeds)
            } catch {
                print("Error al decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
        
        
    }
    
    
}
