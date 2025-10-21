//
//  HomeUsers.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 23-07-25.
//
import SwiftUI

struct HomeUsers: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Text("Bienvenidos")
                .foregroundColor(.white)
        }
        .navigationTitle("Usuarios") 
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        HomeUsers()
    }
}
