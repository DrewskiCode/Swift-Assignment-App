//
//  AssignmentStore.swift
//  AssignmentList
//
//  Created by Drew Floyd on 10/24/24.
//

import Foundation
import SwiftUI

class AssignmentStore: ObservableObject {
    @Published var assignments: [Assignment]
    
    init(assignments: [Assignment] = []) {
        self.assignments = assignments
    }
}


