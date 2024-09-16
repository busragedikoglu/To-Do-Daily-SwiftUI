//
//  ToDo.swift
//  ToDoApp
//
//  Created by Büşra Gedikoğlu on 1.09.2024.
//

import Foundation
import SwiftData

@Model
final class ToDo: Identifiable {
    var id = UUID()
    var title: String
    var time: Date
    var isChecked: Bool

    init(id: UUID = UUID(), title: String, time: Date, isChecked: Bool = false) {
        self.id = id
        self.title = title
        self.time = time
        self.isChecked = isChecked
    }
}
