//
//  MainTabView.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 10/27/22.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "BackgroundBlue")
    }
    
    let gradientBackground = LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
            TabView {
                ContentView().tabItem {
                    Image(systemName: "eye")
                    Text("List")
                }.tag(0).background(gradientBackground)
                ScrollSelectView().tabItem {
                    Image(systemName: "eye")
                    Text("Scroll")
                }.tag(1).background(gradientBackground)
                NavigationSelectView().tabItem {
                    Image(systemName: "eye")
                    Text("Navigation")
                }.tag(2).background(gradientBackground)
            }
            .accentColor(.white).tint(.cyan)
        }
}
