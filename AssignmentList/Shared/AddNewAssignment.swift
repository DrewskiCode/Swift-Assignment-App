//
//  AddNewAssignment.swift
//  AssignmentList
//
//  Created by Drew Floyd on 10/24/24.
//
import SwiftUI

struct AddNewAssignment: View {
    @Environment(\.presentationMode) var presentationMode // Environment property for dismissing the view (Stack Overflow)
    @State var assignmentStore: AssignmentStore
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var time: Int = 0
    
    var body: some View {
        VStack { // Add a new assignment page
            Text("Add New Assignment")
                .font(.headline)
            
            TextField("Assignment Name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $description)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Text("Estimated Time (minutes)")
                TextField("Time", value: $time, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Button(action: {
                // Create and add a new assignment from the data collected
                let newAssignment = Assignment(id: UUID().uuidString, name: name, description: description, time: time)
                assignmentStore.assignments.append(newAssignment)
                
                // Close the Add view
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Assignment")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

// Preview
struct AddNewAssignment_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAssignment(assignmentStore: AssignmentStore())
    }
}
