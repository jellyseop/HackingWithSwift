//
//  ExpenseList.swift
//  iExpense
//
//  Created by junseopLee on 12/16/25.
//
import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Query var expenses: [Expense]
    
    init(for expenseType: ExpenseType, sortOrder: [SortDescriptor<Expense>]) {
        let targetTypeID = expenseType.rawValue
        
        _expenses = Query(filter: #Predicate<Expense> { expense in
            expense.typeID == targetTypeID
        }, sort: sortOrder)
    }
    
    var body: some View {
        List(expenses) { expense in
            NavigationLink(value: expense) {
                HStack {
                    Text(expense.name)
                    Spacer()
                    Text(String(expense.amount))
                }
            }
        }
    }
}
    
#Preview {
    ExpensesView(for: ExpenseType.personal, sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
