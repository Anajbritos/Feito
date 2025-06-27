//
//  Task.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 23/06/25.
//

import Foundation

struct Task: Codable {
    var id =  UUID()
    let title: String
    let description: String
    let isImportant: Bool
    let isCompleted: Bool
    let dueDate: Date?
    
    init(title: String = "",
         description: String = "",
         isImportant: Bool = false,
         isCompleted: Bool = false,
         dueDate: Date? = nil) {
        self.title = title
        self.description = description
        self.isImportant = isImportant
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}


