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
        NavigationStack {
            Form {
                TextField("Enter habit", text: $title)
                TextField("Enter description", text: $description)
            }.navigationTitle("Add New")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("save") {
                            if title.isEmpty {
                                return
                            }
                            
                            let habitItem = HabitItem(id: UUID(), title: title, description: description, count: 0)
                            habit.items.append(habitItem)
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    let habit = Habit()
    AddView(habit: habit)
}

