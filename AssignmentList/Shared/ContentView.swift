//
//  ContentView.swift
//  AssignmentList
//
//  Created by Drew Floyd on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentStore: AssignmentStore = AssignmentStore(assignments: assignmentData)
    @State private var showingAddAssignment = false
    @State private var isEditing = false
    
    var body: some View {
        NavigationView { // Start of the Navigation View
            List {
                ForEach(assignmentStore.assignments, id: \.id) { assignment in
                    NavigationLink(destination: AssignmentDetail(selectedAssignment: assignment)) { // Navigation Link with destination of the Detail View page
                        ListCell(assignment: assignment)
                    }
                }
                .onDelete(perform: deleteAssignment)
                .onMove(perform: moveAssignment)
            }
            .navigationTitle("Assignments")
            .toolbar {
                // Add button for creating a new assignment
                // Navigation to Add page
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddAssignment = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
                // Edit button for enabling delete and move functions for the Assignments
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            // Present AddNewAssignment view as a sheet
            .sheet(isPresented: $showingAddAssignment) {
                AddNewAssignment(assignmentStore: assignmentStore)
            }
        }
    }
    
    // Functions for editing (delete and move)
    private func deleteAssignment(at offsets: IndexSet) {
        assignmentStore.assignments.remove(atOffsets: offsets)
    }
    
    private func moveAssignment(from source: IndexSet, to destination: Int) {
        assignmentStore.assignments.move(fromOffsets: source, toOffset: destination)
    }
}

struct ListCell: View {
    var assignment: Assignment
    var body: some View {
        HStack {
            Text(assignment.name)
                .padding()
                .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

