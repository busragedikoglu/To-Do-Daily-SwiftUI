//
//  ToDoListView.swift
//  ToDoApp
//
//  Created by Büşra Gedikoğlu on 2.09.2024.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel = ToDoListViewModel()
    @State private var showDeleteConfirmation: Bool = false
    @StateObject var addToDoViewModel = AddToDoViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.toDos) { toDo in
                    HStack {
                        Button {
                            viewModel.checkChanged(toDo: toDo, context: context)
                        } label: {
                            Image(systemName: toDo.isChecked ? "checkmark.square.fill" : "square")
                                .foregroundColor(toDo.isChecked ? Color(UIColor.systemBlue) : Color.secondary)
                        }
                        Text(toDo.title)
                            .strikethrough(toDo.isChecked, color: .black)
                        Spacer()
                        Text(viewModel.formatDate(toDo.time))
                    }
                }.onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.deleteToDos(toDo: viewModel.toDos[index], context: context)
                    }
                }
            }.navigationTitle("To Do List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.checkAllToDo(context: context)
                        }) {
                            Image(systemName: viewModel.isCheck ? "checkmark.square.fill" : "square")
                                .foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showDeleteConfirmation = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                        }.disabled(viewModel.toDos.filter { $0.isChecked }.isEmpty)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddToDoView()) {
                            Text("Add To Do")
                                .foregroundColor(.black)
                        }
                    }
                }
                .foregroundColor(.black)
                .onAppear {
                    viewModel.fetchToDos(context: context)
                    viewModel.resetAllChecked(context: context)
                }
                .onDisappear {
                    viewModel.resetAllChecked(context: context)
                }
                .alert("Are you sure\nyou want to delete items?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        viewModel.deleteCheckedToDos(context: context)
                    }
                    Button("Cancel", role: .cancel) {}
                }
        }
    }
}
