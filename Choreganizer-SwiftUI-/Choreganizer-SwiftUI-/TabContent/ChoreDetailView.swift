//
//  ChoreDetailView.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 10/25/22.
//

import Foundation
import SwiftUI

struct ChoreDetailView: View {
    
    @State var day: Day
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text(day.name!)
            let choreArray = day.chores?.array as! [Chore]
            ForEach(choreArray) { chore in
                Text(chore.body ?? "")
            }.onDelete(perform: { offset in
                //self.removeItems(at: offset, from: day)
                //TODO can add and delete
            })
        }.toolbar {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Back")
            }
        }
    }
}
