//
//  AddView.swift
//  iHabit
//
//  Created by junseopLee on 12/1/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    var habit: Habit
    
    @State private var title = ""
    @State private var description = ""
    var body: some View {
        Form {
            TextField("Enter habit", text: $title)
            TextField("Enter description", text: $description)
        }.navigationTitle("Add New")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("save") {
                        let habitItem = HabitItem(title: title, description: description, count: 0)
                        habit.items.append(habitItem)
                        dismiss()
                    }
                }
            }
        
    }
}


