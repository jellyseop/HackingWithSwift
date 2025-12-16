//
//  iExpenseApp.swift
//  iExpense
//
//  Created by junseopLee on 11/24/25.
//
import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Expense.self)
    }
}
