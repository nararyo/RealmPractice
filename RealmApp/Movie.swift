//
//  Movie.swift
//  RealmApp
//
//  Created by NR on 2020/11/11.
//  Copyright © 2020 nararyo. All rights reserved.
//

import Foundation
import RealmSwift

class Section: Object {
    
    @objc dynamic var name: String = ""
    let tasks = LinkingObjects(fromType: Task.self, property: "section")
    
}

class Task: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var section: Section?
}
