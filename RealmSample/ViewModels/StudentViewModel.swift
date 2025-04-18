//
//  StudentViewModel.swift
//  RealmSample
//
//  Created by Venkata Sudhakar Reddy on 16/04/25.
//
import Foundation
import RealmSwift

class StudentViewModel: ObservableObject {
    
    @Published var students: [Student] = []
    private var realm: Realm
    
    init() {
        // Initialize Realm
        realm = try! Realm()
        fetchStudents()
    }
    
    func addStudent(name: String, age: String, address:String) {
        let student = Student()
        student.name = name
        student.age = age
        student.address = address
        try! realm.write {
            realm.add(student)
        }
        fetchStudents()
    }
    
    func updateStudent(_ student: Student, name: String, age: String, address:String) {
        guard let existingStudent = realm.object(ofType: Student.self, forPrimaryKey: student.id) else {
            print("Student not found in Realm")
            return
        }
        //Update record
        do {
            try realm.write {
                existingStudent.name = name
                existingStudent.age = age
                existingStudent.address = address
            }
            fetchStudents()
        } catch {
            print("Failed to update student: \(error.localizedDescription)")
        }
    }
    
    
    func fetchStudents(){
        let results = realm.objects(Student.self)
        students = Array(results)
    }
    
    func deleteStudent(_ student: Student) {
        try! realm.write {
            realm.delete(student)
            fetchStudents()
        }
    }
}
