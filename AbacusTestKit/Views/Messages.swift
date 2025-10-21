//
//  Messages.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import SwiftUI

struct Messages: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Text("Mensajes")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    Messages()
}
