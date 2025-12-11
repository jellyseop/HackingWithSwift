//
//  BookwormApp.swift
//  Bookworm
//
//  Created by junseopLee on 12/10/25.
//
import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Book.self)
    }
}
