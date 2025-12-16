//
//  EditView.swift
//  iExpense
//
//  Created by junseopLee on 12/16/25.
//
import SwiftData
import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var expense: Expense
    
    
    @State private var showingDeleteAlert = false
    var body: some View {
        Form {
            Section("Transaction Details") {
                TextField("Name", text: $expense.name)
                
                Picker("Type", selection: $expense.type) {
                    ForEach(ExpenseType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                
                TextField("Amount", value: $expense.amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Button(role: .destructive) {
                    showingDeleteAlert.toggle()
                } label: {
                    Text("Delete Expense")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }
        }.alert("Delete Expense", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                modelContext.delete(expense)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure? This action cannot be undone.")
        }
    }
}


