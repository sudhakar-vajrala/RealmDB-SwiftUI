//
//  AddStudentView.swift
//  RealmSample
//
//  Created by Venkata Sudhakar Reddy on 16/04/25.
//

import SwiftUI

struct AddStudentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: StudentViewModel

    var student: Student?
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var address: String = ""
    
    var isEditing: Bool {
        student != nil
        }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Student Info")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                    TextField("Address", text: $address)
                }
                
                Button(action: {
                    if !name.isEmpty && !age.isEmpty && !address.isEmpty {
                        if isEditing {
                            viewModel.updateStudent(student ?? Student(), name: name, age: age, address: address)
                        }else{
                            viewModel.addStudent(name: name, age: age, address: address)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text(isEditing ? "Update Student" :"Add Student")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!isFormValid)
            }
            .navigationTitle(isEditing ? "Update Student" :"Add Student")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear() {
                if let student = student {
                    name = student.name
                    age = student.age
                    address = student.address
                }
            }
        }
    }
    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !age.trimmingCharacters(in: .whitespaces).isEmpty && !address.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

#Preview {
    AddStudentView(viewModel: StudentViewModel(), student: Student())
}
