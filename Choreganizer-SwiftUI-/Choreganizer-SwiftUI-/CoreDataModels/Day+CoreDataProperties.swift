//
//  Day+CoreDataProperties.swift
//  Choreganizer-SwiftUI-
//
//  Created by Ethan Hess on 11/22/22.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var name: String?
    @NSManaged public var chores: NSOrderedSet?

}

// MARK: Generated accessors for chores
extension Day {

    @objc(insertObject:inChoresAtIndex:)
    @NSManaged public func insertIntoChores(_ value: Chore, at idx: Int)

    @objc(removeObjectFromChoresAtIndex:)
    @NSManaged public func removeFromChores(at idx: Int)

    @objc(insertChores:atIndexes:)
    @NSManaged public func insertIntoChores(_ values: [Chore], at indexes: NSIndexSet)

    @objc(removeChoresAtIndexes:)
    @NSManaged public func removeFromChores(at indexes: NSIndexSet)

    @objc(replaceObjectInChoresAtIndex:withObject:)
    @NSManaged public func replaceChores(at idx: Int, with value: Chore)

    @objc(replaceChoresAtIndexes:withChores:)
    @NSManaged public func replaceChores(at indexes: NSIndexSet, with values: [Chore])

    @objc(addChoresObject:)
    @NSManaged public func addToChores(_ value: Chore)

    @objc(removeChoresObject:)
    @NSManaged public func removeFromChores(_ value: Chore)

    @objc(addChores:)
    @NSManaged public func addToChores(_ values: NSOrderedSet)

    @objc(removeChores:)
    @NSManaged public func removeFromChores(_ values: NSOrderedSet)

}

extension Day : Identifiable {

}
