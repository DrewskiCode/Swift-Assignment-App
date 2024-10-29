//
//  Assignment.swift
//  AssignmentList
//
//  Created by Drew Floyd on 10/24/24.
//

import Foundation

import SwiftUI

struct Assignment : Hashable, Codable, Identifiable {
    var id: String // to structure the Assignments
    var name: String // name of Assignment
    var description: String // description of Assignment
    var time: Int // estimated time of Assignment
    
}
