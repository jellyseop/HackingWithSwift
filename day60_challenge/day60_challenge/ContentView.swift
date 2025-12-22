//
//  ContentView.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    List(users) { user in
                            NavigationLink(value: user) {
                                HStack {
                                    Image(systemName: user.isActive ? "circle.fill": "circle")
                                        .foregroundStyle(user.isActive ? .green : .gray)
                                    Text(user.name)
                                }
                            }.disabled(!user.isActive)
                    }
                }
             
                if isLoading {
                    ProgressView()
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetail(user: user)
            }
            .navigationTitle("Users  (\(users.count))")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        isLoading = true
        users = []
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            users = decodedUsers
            isLoading = false
            
            print("성공! 데이터 개수: \(users.count)")
            
        } catch {
            print("디코딩 실패 원인: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
