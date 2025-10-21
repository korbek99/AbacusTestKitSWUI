//
//  UtilServices.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation

class UtilServices {
    var onError: ((Error) -> Void)?
    public func getEndpoint(fromName: String) -> APIEndpointModel? {
            var endpointFile = ""
            #if DEBUG
                endpointFile = "endpointsDev"
            #else
                endpointFile = "endpoints"
            #endif
            debugPrint(endpointFile)
            guard let path = Bundle.main.path(forResource: endpointFile, ofType: "plist") else {
                debugPrint(NSLocalizedString("INFO_PLIST_ERROR", comment: "error message"))
                self.onError?(NSLocalizedString("INFO_PLIST_ERROR", comment: "error message") as! Error)
                return nil
            }
            let myDict = NSDictionary(contentsOfFile: path) as! [String : Any]
            guard let endpoint = myDict[fromName] as? [String : String] else {
                debugPrint("ERROR: No existe endpoint con el nombre \(fromName)")
                return nil
            }
            return APIEndpointModel(url: URL(string: endpoint["url"]!)!, APIKey: endpoint["x-api-key"]!, APIToken: endpoint["x-api-token"])
        }
}
