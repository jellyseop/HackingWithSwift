//
//  ContentView.swift
//  iExpense
//
//  Created by junseopLee on 11/24/25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let decoded = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from:decoded) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @State private var expenses = Expenses()
    
    var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    enum NavigationRoute: Hashable {
        case addExpense
    }
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseListSection(title: "Personal", items: personalItems, deleteAction: { offsets in
                    removeItems(at: offsets, from: personalItems)
                })
                
                ExpenseListSection(title: "Business", items: businessItems, deleteAction: { offsets in
                    removeItems(at: offsets, from: businessItems)})
                
                
            }.navigationTitle("IExpense")
                .navigationDestination(for: NavigationRoute.self) { route in
                    switch route {
                    case .addExpense:
                        AddView(expenses: expenses)
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink(value: NavigationRoute.addExpense) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }
    
    
    func removeItems(at offsets: IndexSet, from filteredItems: [ExpenseItem]) {
        let itemsToDelete = offsets.map {
            filteredItems[$0].id
        }
        
        expenses.items.removeAll {item in itemsToDelete.contains(item.id)}
    }
}

#Preview {
    ContentView()
}
