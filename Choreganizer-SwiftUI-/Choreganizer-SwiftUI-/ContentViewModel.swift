//
//  ContentViewModel.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 10/25/22.
//

import Foundation
import CoreData
import SwiftUI

//OO = A type alias for the Combine framework’s type for an object with a publisher that emits before the object has changed.

//View model = a middleman between a view and a data source

class ContentViewModel : ObservableObject {
    
    //MARK: Properties
    let container = NSPersistentContainer(name: "MainCoreDataModel") //A container that encapsulates the Core Data stack in your app.
    let defaults = UserDefaults.standard
    let hasLaunchedKey = "hasLaunchedKey"
    
    //MARK: for subscribers
    @Published var days: [Day] = []
    
    //MARK: Init
    init() {
        loadStores()
    }
    
    fileprivate func loadStores() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Description from stores: \(description)")
            }
        }
        
        checkIfDaysExist()
    }
    
    //On initial launch need to add days
    fileprivate func checkIfDaysExist() {
        if !defaults.bool(forKey: "hasLaunched") {
            
            //let managedObjectContext = dataController.container.viewContext
            let managedObjectContext = container.viewContext
            
            let monday = Day(context: managedObjectContext)
            monday.name = "Monday"
            let tuesday = Day(context: managedObjectContext)
            tuesday.name = "Tuesday"
            let wednesday = Day(context: managedObjectContext)
            wednesday.name = "Wednesday"
            let thursday = Day(context: managedObjectContext)
            thursday.name = "Thursday"
            let friday = Day(context: managedObjectContext)
            friday.name = "Friday"
            let saturday = Day(context: managedObjectContext)
            saturday.name = "Saturday"
            let sunday = Day(context: managedObjectContext)
            sunday.name = "Sunday"
            
            //Test chore (can delete)
            
            let testChoreMonday = Chore(context: managedObjectContext)
            testChoreMonday.body = "This is a test that will display under Monday"
            testChoreMonday.day = monday
            testChoreMonday.isComplete = false
            testChoreMonday.uid = UUID().uuidString
            testChoreMonday.imageData = nil
            
            do {
                try managedObjectContext.save()
            } catch let error {
                let error = error as NSError
                fatalError("Core data error App entry point: \(error)")
            }
            
            defaults.set(true, forKey: "hasLaunched")
        }
        
        fetchDays()
    }
    
    fileprivate func fetchDays() {
        let request = NSFetchRequest<Day>(entityName: "Day")
        do {
           //MARK: Sort days since order is not necessarily kept in core data without some sort of predicate
            //Instead of doing this here, may be better to attempt double property wrapper
            
            //Used this for help but changed a view things https://stackoverflow.com/questions/53135422/swift-need-to-sort-an-array-of-string-days-of-week
            
            let weekdays = Calendar.current.weekdaySymbols.enumerated()
            var weekdaysDict = [String: Int]()
            weekdays.forEach { weekdaysDict[$0.1] = $0.0 }
            
            var dayArray = try container.viewContext.fetch(request)
            dayArray.sort(by: { weekdaysDict[$0.name!] ?? -1 < weekdaysDict[$1.name!] ?? -1 })
            
            self.days = dayArray
            
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    //MARK: Public funcs.
    func addChoreToDay(day: Day, choreBody: String, imageData: Data?) {
        
        let newChore = Chore(context: container.viewContext)
        newChore.day = day
        newChore.body = choreBody
        newChore.imageData = imageData
        newChore.uid = UUID().uuidString
        newChore.isComplete = false
        
        saveData()
    }
    
 
    func removeChore(_ chore: Chore) {
        container.viewContext.delete(chore)
        saveData()
    }
    
    func editChore(_ chore: Chore) {
        //TODO add.
    }
    
    
    fileprivate func saveData() {
        do {
            try container.viewContext.save()
            fetchDays()
            //try moc.save()
        } catch {
            let error = error as NSError
            fatalError("Core data error View: \(error)")
        }
    }
}
