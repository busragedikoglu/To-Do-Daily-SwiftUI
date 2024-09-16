//
//  ToDoList.swift
//  ToDoApp
//
//  Created by Büşra Gedikoğlu on 1.09.2024.
//

import Foundation
import SwiftData

class ToDoListViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published var isCheck: Bool = false

    func fetchToDos(context: ModelContext) {
        let toDo = FetchDescriptor<ToDo>()

        do {
            let fetchToDos = try context.fetch(toDo)
            toDos = fetchToDos.sorted(by: { $0.time < $1.time })
            updateIsCheck()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteToDos(toDo: ToDo, context: ModelContext) {
        context.delete(toDo)

        do {
            try context.save()
            fetchToDos(context: context)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteCheckedToDos(context: ModelContext) {
        let checkedToDos = toDos.filter { $0.isChecked }

        for toDo in checkedToDos {
            context.delete(toDo)
        }

        do {
            try context.save()
            fetchToDos(context: context)
        } catch {
            print(error.localizedDescription)
        }
    }

    func formatDate(_ date: Date) -> String {
        let format = DateFormatter()
        format.dateStyle = .none
        format.timeStyle = .short
        return format.string(from: date)
    }

    func checkChanged(toDo: ToDo, context: ModelContext) {
        toDo.isChecked.toggle()

        do {
            try context.save()
            fetchToDos(context: context)
        } catch {
            print(error.localizedDescription)
        }
    }

    func checkAllToDo(context: ModelContext) {
        let allChecked = toDos.allSatisfy { $0.isChecked }
        for toDo in toDos {
            toDo.isChecked = !allChecked
        }
        do {
            try context.save()
            fetchToDos(context: context)
        } catch {
            print(error.localizedDescription)
        }
    }

    func resetAllChecked(context: ModelContext) {
        for toDo in toDos {
            toDo.isChecked = false
        }

        do {
            try context.save()
            fetchToDos(context: context)
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateIsCheck() {
        isCheck = toDos.allSatisfy { $0.isChecked }
    }
}
