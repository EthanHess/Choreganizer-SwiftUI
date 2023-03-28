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
    
    @State var pickerPresented = false
    @State var fireDate = Date.now
    
    //Date picker, present then pass back binding date
    //TODO keep track of existing notifications and enable cancellation
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    let days = viewModel.days
                    ForEach(0..<days.count, id: \.self) { index in
                        let day = days[index]
                        Spacer()
                        Text(day.name!).onTapGesture {
                            selectedDay = day
                        }
                        Spacer()
                    }
                }
            }
            List {
                if let currentDay = selectedDay {
                let choreArray = currentDay.chores?.array as! [Chore]
                    ForEach(choreArray) { chore in
                        HStack {
                            Spacer()
                            Text(chore.body ?? "")
                            Spacer()
                            Button(action: self.togglePicker) {
                                Image("alarm")
                            }.cornerRadius(5).sheet(isPresented: self.$pickerPresented){
                                PickerContainer(fireDate: $fireDate, didDismiss: { self.addNotificationForChore(chore: chore) })
                            }
                            Spacer()
                        }
                    }.onDelete(perform: { offset in
                        self.removeItems(at: offset, from: currentDay)
                    })
                }
            }
        }.onAppear {
            selectedDay = viewModel.days[0]
        }
    }
    
    func togglePicker() {
        self.pickerPresented = true
    }
    
    //MARK: TODO Move to controller for cleaner code
    func addNotificationForChore(chore: Chore) {
        //Present date picker then assign accordingly
        
        pickerPresented = false
        
        guard let choreBody = chore.body else {
            //Alert, something went wrong
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = choreBody
        
        //MARK: From Apple's example, will want to change repeats to choice though and set correct date from date picker
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = 3  // Tuesday
        dateComponents.hour = 14    // 14:00 hours
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
               print("Error sending notification \(error!.localizedDescription)")
           } else {
               print("Notification sent successfully!")
           }
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
