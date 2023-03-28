//
//  PickerContainer.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 3/28/23.
//

import Foundation
import SwiftUI

//Pick a fire time for the notification
struct PickerContainer: View {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()

    @Binding var fireDate : Date
    var didDismiss: () -> Void

    var body: some View {
        VStack {
            DatePicker(selection: $fireDate, displayedComponents: [.date, .hourAndMinute]) {
                Text("Select a date and time to be notified")
            }
            Text("Fire Date: \(fireDate, formatter: dateFormatter)")
            Button {
                didDismiss()
            } label: {
                Text("Okay")
            }
        }
    }
}
