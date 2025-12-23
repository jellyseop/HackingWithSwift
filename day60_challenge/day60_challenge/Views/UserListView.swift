//
//  UserListView.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//

import SwiftUI

struct UserListView: View {
    let users: [User]
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack {
                    Image(systemName: user.isActive ? "circle.fill": "circle")
                        .foregroundStyle(user.isActive ? .green : .gray)
                    Text(user.name)
                }
            }
            .disabled(!user.isActive)
        }
        .overlay {
            if users.isEmpty {
                ContentUnavailableView("No Users", systemImage: "person.slash", description: Text("There are no users in this category."))
            }
        }
    }
}

