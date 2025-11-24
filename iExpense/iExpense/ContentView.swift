//
//  ContentView.swift
//  iExpense
//
//  Created by junseopLee on 11/24/25.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String

    var body: some View {
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @AppStorage("tapCount")  private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    ContentView()
}
