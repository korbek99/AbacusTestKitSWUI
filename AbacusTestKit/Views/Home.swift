//
//  Home.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//
import SwiftUI

struct Home: View {

    init() {
        navegationSet()
        tabbarSet()
      }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            TabView {
                NavigationView {
                    Trade()
                        .navigationTitle("Trades")
                }
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Patrimonio")
                }

                NavigationView {
                    Wallet()
                        .navigationTitle("Wallet")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Image(systemName: "wallet.pass.fill")
                    Text("Wallet")
                }

                NavigationView {
                    //Searching()
                    SearchNew()
                        .navigationTitle("Buscar")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Buscar")
                }

                NavigationView {
                    Messages()
                        .navigationTitle("Mensajes")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Mensajes")
                }

                NavigationView {
//                    VStack {
//                        Text("Bienvenido")
//                    }
                    HomeUsers()
                    //.navigationTitle("Cuentas")
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Home")
                }
            }
            .modifier(TabBarModifier(backgroundColor: UIColor.black))
            //.accentColor(.white)
        }
    }
}

#Preview {
    Home()
}
