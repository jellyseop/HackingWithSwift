//
//  ContentView.swift
//  iExpense
//
//  Created by junseopLee on 11/24/25.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @Environment(\.modelContext) var modelContext
    
    @State private var filter = ExpenseType.business
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    
    var body: some View {
        NavigationStack {
            ExpensesView(for: filter, sortOrder: sortOrder)
                .navigationTitle("IExpense")
                .navigationDestination(for: Expense.self) { expense in
                    EditView(expense: expense)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Samples", systemImage: "plus") {
                            showingAddExpense.toggle()
                            //try? modelContext.delete(model: Expense.self)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Menu(filter.rawValue) {
                                Picker("Filter", selection: $filter) {
                                    ForEach(ExpenseType.allCases, id: \.self) { type in
                                        Text(type.rawValue)
                                    }
                                }
                            }
                            Menu("Sort", systemImage: "slider.horizontal.3") {
                                Picker("Sort", selection: $sortOrder) {
                                    Text("Sort By Name")
                                        .tag([
                                            SortDescriptor(\Expense.name),
                                            SortDescriptor(\Expense.amount)
                                        ])
                                    Text("Sort By Amount")
                                        .tag([
                                            SortDescriptor(\Expense.amount),
                                            SortDescriptor(\Expense.name)
                                        ])
                                }
                            }
                        }
                        
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView()
                }
        }
    }
}


#Preview {
    ContentView()
}
