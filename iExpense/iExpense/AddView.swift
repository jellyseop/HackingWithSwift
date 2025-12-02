//
//  AddView.swift
//  iExpense
//
//  Created by junseopLee on 11/25/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD")).keyboardType(.decimalPad)
            }.navigationTitle($name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let finalName = name.isEmpty ? "Unknown" : name
                            let expense = ExpenseItem(name: finalName, type: type, amount: amount)
                            expenses.items.append(expense)
                            
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
