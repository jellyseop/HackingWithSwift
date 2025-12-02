//
//  ContentView.swift
//  iHabit
//
//  Created by junseopLee on 12/1/25.
//

import SwiftUI

struct HabitItem: Codable, Hashable, Identifiable, Equatable {
    let id: UUID
    let title: String
    let description: String
    var count: Int
}

@Observable
class Habit {
    var items = [HabitItem] () {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "items") {
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: data) {
                self.items = decoded
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @State private var habit = Habit()
    @State private var showAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habit.items) { item in
                    NavigationLink(value: item.id) {
                        HStack {
                            Text(item.title).font(.headline.bold())
                            Spacer()
                            Text(item.count.formatted())
                        }
                    }
                }.onDelete(perform: deleteHabit)
                
            }.navigationTitle("iHabit")
                .navigationDestination(for: UUID.self) { id in
                    if let index = habit.items.firstIndex(where: {$0.id == id}){
                        HabitDetail(item: $habit.items[index])
                    } else {
                        Text("항목을 찾을 수 없습니다.")
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            showAddView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddView) {
                    AddView(habit: habit)
                }
        }
    }
    
    func deleteHabit(at offsets: IndexSet) {
        habit.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
