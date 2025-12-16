//
//  Expense.swift
//  iExpense
//
//  Created by junseopLee on 12/16/25.
//

import Foundation
import SwiftData

enum ExpenseType: String, Codable, CaseIterable {
    case business = "Business"
    case personal = "Personal"
}

@Model
class Expense {
    var name: String
    
    var typeID: String
    var type: ExpenseType {
            get { ExpenseType(rawValue: typeID) ?? .personal }
            set { typeID = newValue.rawValue }
        }
    
    
    var amount: Double
    
    init(name: String, type: ExpenseType, amount: Double) {
        self.name = name
        self.typeID = type.rawValue
        self.amount = amount
    }
}
