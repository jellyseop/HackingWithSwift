//
//  ContentView.swift
//  iHabit
//
//  Created by junseopLee on 12/1/25.
//

import SwiftUI

struct HabitItem: Codable, Hashable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    var count: Int
}

@Observable
class Habit {
    var items = [HabitItem] ()
    
    init() {
        self.items = []
    }
}

struct ContentView: View {
    @State private var habit = Habit()
    
    var body: some View {
        NavigationStack {
            Text("Hello World")
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                         AddView(habit: habit)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        
    }
}

#Preview {
    ContentView()
}
