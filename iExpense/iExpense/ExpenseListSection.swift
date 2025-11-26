//
//  ExpenseListSection.swift
//  iExpense
//
//  Created by junseopLee on 11/26/25.
//

import SwiftUI

struct ExpenseListSection: View {
    let title: String
    let items: [ExpenseItem]
    
    let deleteAction: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading){
                        Text(item.name).font(.headline)
                        Text(item.type).font(.subheadline).foregroundStyle(.gray)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).font(.headline.bold()).foregroundStyle(item.amount <= 10.0 ? .gray : item.amount <= 100 ? .cyan : .blue)
                }
                
            }.onDelete(perform: deleteAction)
        }
    }
}


