//
//  Grocery.swift
//  Grocery List
//
//  Created by Idris Jafer on 6/9/15.
//  Copyright (c) 2015 Idris Jafer. All rights reserved.
//

import Foundation
import CoreData

class Grocery: NSManagedObject {

    @NSManaged var item: String
    @NSManaged var qty: String
    @NSManaged var note: String

}
