//
//  Wallet.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import SwiftUI

struct Wallet: View {
    
    init() {
        navegationSet()
        tabbarSet()
      }
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all, edges: .all)
            
            Text("Wallet")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    Wallet()
}
