//
//  AddToDo.swift
//  ToDoApp
//
//  Created by Büşra Gedikoğlu on 1.09.2024.
//

import Foundation
import SwiftData

class AddToDoViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var time: Date = Date()
    let toDos: [ToDo] = []

    var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func save(context: ModelContext) {
        let toDo = ToDo(title: title, time: time)
        context.insert(toDo)

        do {
            try context.save()
            print(toDo.title)
        } catch {
            print(error.localizedDescription)
        }
    }
}
