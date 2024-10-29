//
//  AssignmentData.swift
//  AssignmentList
//
//  Created by Drew Floyd on 10/24/24.
//

import Foundation
import SwiftUI

var assignmentData: [Assignment] = loadJson("assignmentData.json")

func loadJson<A: Decodable>(_ filename: String) -> A {
    let data: Data

    // Attempt to locate the JSON file in the main bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
        print("Data loaded successfully from \(file)")
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(A.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(A.self):\n\(error)")
    }
}


