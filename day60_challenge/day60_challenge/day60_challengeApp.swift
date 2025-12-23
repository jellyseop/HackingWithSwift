//
//  day60_challengeApp.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//
import SwiftData
import SwiftUI

@main
struct day60_challengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
