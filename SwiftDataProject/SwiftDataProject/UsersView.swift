//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by junseopLee on 12/15/25.
//
import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    
    init(minimunDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> {user in
            user.joinDate >= minimunDate
        }, sort: sortOrder)
    }
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack{
                    Text(user.name)
                    Spacer()
                    Text(String(user.jobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                
            }
        }
    }
}

#Preview {
    UsersView(minimunDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
