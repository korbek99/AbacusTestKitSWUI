//
//  AbacusTestKitApp.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import SwiftUI

@main
struct AbacusTestKitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
            //ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
