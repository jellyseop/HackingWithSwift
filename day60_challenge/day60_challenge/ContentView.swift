//
//  ContentView.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//
import SwiftData
import SwiftUI

enum Tab {
    case all, active, inactive
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    @State private var selectedTab: Tab = .all
    @State private var isLoading = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                UserListView(users: users)
                    .navigationTitle("All Users")
                    .navigationDestination(for: User.self) { user in
                        UserDetailView(user: user)
                    }
            }
            .tabItem {
                Label("All", systemImage: "person.3")
            }
            .tag(Tab.all)
            
            NavigationStack {
                UserListView(users: users.filter { $0.isActive })
                    .navigationTitle("Active Users")
                    .navigationDestination(for: User.self) { user in
                        UserDetailView(user: user)
                    }
            }
            .tabItem {
                Label("Active", systemImage: "person.fill.checkmark")
            }
            .tag(Tab.active)
            
            NavigationStack {
                UserListView(users: users.filter { !$0.isActive })
                    .navigationTitle("Inactive Users")
                    .navigationDestination(for: User.self) { user in
                        UserDetailView(user: user)
                    }
            }
            .tabItem {
                Label("Inactive", systemImage: "person.slash")
            }
            .tag(Tab.inactive)
        }
        .background(.ultraThinMaterial)
        .task {
            if users.isEmpty {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        isLoading = true
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let userDTOs = try decoder.decode([UserDTO].self, from: data)
            
            for dto in userDTOs {
                let user = User(from: dto)
                modelContext.insert(user)
            }
            isLoading = false
            
        } catch {
            print("디코딩 실패 원인: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
