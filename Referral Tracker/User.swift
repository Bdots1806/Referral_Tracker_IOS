//
//  User.swift
//  Referral Tracker
//
//  Created by user214269 on 12/10/22.
//

import CoreData

@objc(User)

class User: NSManagedObject {
    @NSManaged public var id: Int32
    @NSManaged public var password: String?
    @NSManaged public var rCode: String?
    @NSManaged public var uPoint: Int32
    @NSManaged public var username: String?

}
