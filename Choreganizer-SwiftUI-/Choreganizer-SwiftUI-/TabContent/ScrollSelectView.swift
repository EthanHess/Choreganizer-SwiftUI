//
//  ScrollSelectView.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 10/27/22.
//

import Foundation
import SwiftUI

struct ScrollSelectView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var selectedDay : Day?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    let days = viewModel.days
                    ForEach(0..<days.count, id: \.self) { index in
                        let day = days[index]
                        Text(day.name!).onTapGesture {
                            selectedDay = day
                        }
                    }
                }
            }
            List {
                if let currentDay = selectedDay {
                let choreArray = currentDay.chores?.array as! [Chore]
                    ForEach(choreArray) { chore in
                        Text(chore.body ?? "")
                    }.onDelete(perform: { offset in
                        self.removeItems(at: offset, from: currentDay)
                    })
                }
            }
        }.onAppear {
            selectedDay = viewModel.days[0]
        }
    }
    
    //MARK: consolidate this (DRY)
    func removeItems(at offsets: IndexSet, from day: Day) {
        for index in offsets {
            guard let chore = day.chores?[index] else {
                print("No chore to remove")
                return
            }
            viewModel.removeChore(chore as! Chore)
        }
    }
}
