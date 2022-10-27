//
//  NavigationSelectView.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 10/27/22.
//

import Foundation
import SwiftUI

struct NavigationSelectView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(viewModel.days) { day in
                        NavigationLink(day.name!) {
                            ChoreDetailView(day: day)
                        }
                    }
                }
            }
        }
    }
}
