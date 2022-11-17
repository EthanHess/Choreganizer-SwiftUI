//
//  ContentView.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 6/27/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //Now replaced by view model
    
    //MARK: @FetchRequest is a property wrapper making an NSFetchRequest under the hood
    
//    @FetchRequest(sortDescriptors: []) var days: FetchedResults<Day>
    
//    @Environment(\.managedObjectContext) var moc
    
    //Mark private
    @StateObject var viewModel = ContentViewModel()
    
    @State var choreBody = ""
    @State var choreImageData : Data? = nil
    
    @State private var isDetailPresented : Bool = false
    
    //MARK: Eventually configure
    
    var textFieldHeader : some View {
        HStack {
            TextField("Enter in a new task", text: self.$choreBody).padding().background(Color.white).cornerRadius(5).border(Color.black, width: 1)
        }
    }
    
    var body: some View {
            VStack {
                textFieldHeader.padding()
                List {
                    ForEach(viewModel.days) { day in
                        HStack {
                            Text(day.name ?? "")
                            Button {
                                addChore(toDay: day)
                            } label: {
                                Text("+")
                            }
                        }
                        let choreArray = day.chores?.array as! [Chore]
                        ForEach(choreArray) { chore in
                            Text(chore.body ?? "")
                        }.onDelete(perform: { offset in
                            self.removeItems(at: offset, from: day)
                        })
                    }
                }
            }
            
    }
    
    private func addChore(toDay day: Day) {
        if self.choreBody == "" {
            self.presentAlert()
            return
        }
        //Will need to fetch current day
        viewModel.addChoreToDay(day: day, choreBody: self.choreBody, imageData: nil)
    }
    
    func removeItems(at offsets: IndexSet, from day: Day) {
        for index in offsets {
            guard let chore = day.chores?[index] else {
                print("No chore to remove")
                return
            }
            viewModel.removeChore(chore as! Chore)
        }
    }
    
    //private = private to type
    //fileprivate = private to file
    fileprivate func presentAlert() {
        print("No chore body")
    }
}

//Create an Xcode preview by declaring a structure that conforms to the PreviewProvider protocol. Implement the required previews computed property, and return the view to display:

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//MARK: Custom property wrapper

