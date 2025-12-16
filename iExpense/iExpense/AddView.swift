//
//  AddView.swift
//  iExpense
//
//  Created by junseopLee on 11/25/25.
//
import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = "New Expense"
    @State private var type = ExpenseType.business
    @State private var amount = 0.0
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            
            Picker("Type", selection: $type) {
                ForEach(ExpenseType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            
            TextField("Amount", value: $amount, format: .currency(code: "USD")).keyboardType(.decimalPad)
            
            Section {
                Button(role: .confirm) {
                    let finalName = name.isEmpty ? "Unknown" : name
                    let expense = Expense(name: finalName, type: type, amount: amount)
                    
                    modelContext.insert(expense)
                    dismiss()
                } label: {
                     Text("Save")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    AddView()
}
