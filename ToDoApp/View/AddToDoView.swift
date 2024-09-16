//
//  AddToDoView.swift
//  ToDoApp
//
//  Created by Büşra Gedikoğlu on 1.09.2024.
//

import SwiftData
import SwiftUI

struct AddToDoView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = AddToDoViewModel()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $viewModel.title)
                DatePicker("Time", selection: $viewModel.time, displayedComponents: .hourAndMinute)
            }.navigationTitle("Add To Do")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.save(context: context)
                            dismiss()

                        }, label: {
                            Text("Save")
                        }).disabled(!viewModel.isFormValid)
                    }
                }
        }
    }
}

#Preview {
    AddToDoView().modelContainer(for: [ToDo.self])
}
