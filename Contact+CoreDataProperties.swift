//
//  Contact+CoreDataProperties.swift
//  TripText
//
//  Created by webstudent on 12/7/15.
//  Copyright © 2015 Nic Blaski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var email: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?

}
