//
//  StudentListView.swift
//  RealmSample
//
//  Created by Venkata Sudhakar Reddy on 16/04/25.
//
import SwiftUI

struct StudentListView: View {
    @StateObject private var viewModel = StudentViewModel()
    @State private var showAddStudent = false
    @State private var selectedStudent: Student?
    
    var body: some View {
        NavigationView {
            List(viewModel.students) { student in
                VStack(alignment: .leading) {
                    HStack{
                        Text(student.name)
                            .font(.headline)
                        Spacer()
                        Text(student.age)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text("Address: \(student.address)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
                .swipeActions(edge: .trailing){
                    Button(role: .destructive){ viewModel.deleteStudent(student)
                    }label: {
                        Label("Delete", systemImage: "trash")
                    }
                    
                    Button {
                        selectedStudent = student
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.orange)
                }
            }
            .navigationTitle("Student List")
            .navigationBarItems(trailing: Button(action: {
                selectedStudent = nil
                showAddStudent = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(item: $selectedStudent) { student in
                AddStudentView(viewModel: viewModel, student: student)
            }
            .sheet(isPresented: $showAddStudent) {
                AddStudentView(viewModel: viewModel, student: nil)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
