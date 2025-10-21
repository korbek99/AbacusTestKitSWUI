//
//  TabBarModifierUtils.swift
//  AbacusTestKit
//
//  Created by Jose Preatorian on 22-07-25.
//

import Foundation
import SwiftUI

struct TabBarModifier: ViewModifier {
    init(backgroundColor: UIColor) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = backgroundColor

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func tabBarBackground(_ color: UIColor) -> some View {
        self.modifier(TabBarModifier(backgroundColor: color))
    }
}

