//
//  Student.swift
//  RealmSample
//
//  Created by Venkata Sudhakar Reddy on 16/04/25.
//

import Foundation

import RealmSwift

class Student: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    @objc dynamic var address = ""
    
    override static func primaryKey() -> String? {
            return "id"
        }
}
