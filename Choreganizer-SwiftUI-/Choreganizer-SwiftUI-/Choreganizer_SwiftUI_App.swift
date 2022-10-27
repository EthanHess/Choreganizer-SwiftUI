//
//  Choreganizer_SwiftUI_App.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 6/27/22.
//

import SwiftUI

//MARK: Main entry point of app
@main
struct Choreganizer_SwiftUI_App: App {
    
    var body: some Scene {
        WindowGroup {
            //func environment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, _ value: V) -> some View
            //Writable key path here is the managedObjectContext and the value is the container's viewContext
            //viewContext = The main queue’s managed object context.
            
            //ContentView().environment(\.managedObjectContext, dataController.container.viewContext)
            
            //The above exmaple was when we had a MOC we wanted to pass as an environment object 
            //ContentView()
            
            MainTabView()
        }
    }
    
    //TODO notifications (local) for reminders
}
