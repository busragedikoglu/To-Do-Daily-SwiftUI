//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Büşra Gedikoğlu on 1.09.2024.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView().modelContainer(for: [ToDo.self])
        }
    }
}
