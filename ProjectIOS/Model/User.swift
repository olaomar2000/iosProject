//
//  User.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import CoreData

@objc(User)
class User: NSManagedObject
{
    @NSManaged var id: NSNumber?
    @NSManaged var email: String?
    @NSManaged var password: String?
    @NSManaged var username: String?
    @NSManaged var imageUser:Data?
}
