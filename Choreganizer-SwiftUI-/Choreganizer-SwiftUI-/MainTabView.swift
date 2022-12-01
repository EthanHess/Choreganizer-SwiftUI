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
    
    var body: some View {
            TabView {
                ContentView().tabItem {
                    Image(systemName: "eye")
                    Text("List")
                }.tag(0).background(
                    LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing)
                )
                ScrollSelectView().tabItem {
                    Image(systemName: "eye")
                    Text("Scroll")
                }.tag(1)
                NavigationSelectView().tabItem {
                    Image(systemName: "eye")
                    Text("Navigation")
                }.tag(2)
            }
            .accentColor(.white)
        }
}
