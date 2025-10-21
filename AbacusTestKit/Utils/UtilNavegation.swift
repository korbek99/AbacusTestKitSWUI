//
//  UtilNavegation.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 23-07-25.
//

import Foundation
import UIKit

func navegationSet() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.black
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}

func tabbarSet(){
    _ = TabBarModifier(backgroundColor: UIColor.darkGray)
}
