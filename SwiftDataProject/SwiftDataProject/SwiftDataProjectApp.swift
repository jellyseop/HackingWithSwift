//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by junseopLee on 12/13/25.
//
import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
