//
//  Chore+CoreDataProperties.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 6/27/22.
//
//

import Foundation
import CoreData


extension Chore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chore> {
        return NSFetchRequest<Chore>(entityName: "Chore")
    }

    @NSManaged public var body: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var isComplete: Bool
    @NSManaged public var uid: String?
    @NSManaged public var day: Day?

}

extension Chore : Identifiable {

}
