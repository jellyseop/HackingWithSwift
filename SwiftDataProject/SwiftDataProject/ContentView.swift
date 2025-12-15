//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by junseopLee on 12/13/25.
//
import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    
    var body: some View {
        NavigationStack {
            UsersView(minimunDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
                .navigationDestination(for: User.self) { user in
                    EditUserView(user: user)
                }
                .toolbar {
                    Button("Add Samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)
                        
                        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
                        let job1 = Job(name: "Organize sock drawer", priority: 3)
                        let job2 = Job(name: "Make plans with Alex", priority: 4)

                        modelContext.insert(user1)

                        user1.jobs.append(job1)
                        user1.jobs.append(job2)
                    }
                    
                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort By Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            Text("Sort By JoinDate")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
