//
//  UserDetail.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        
        Form {
            Section("Identity") {
                LabeledContent("Age") {
                    Text(String(user.age))
                }
                LabeledContent("Company") {
                    Text(user.company)
                }
                LabeledContent("Email") {
                    Text(user.email)
                }
                LabeledContent("Registered") {
                    Text(user.registered, format: .dateTime.year().month().day())
                }
            }
            
            Section("About") {
                Text(user.about)
            }
            
            
            Section("Friends (\(user.friends.count))") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(user.friends) { friend in
                            Text(friend.name)
                                .font(.headline)
                                .foregroundStyle(.blue)
                                .containerRelativeFrame(.horizontal)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .listRowInsets(EdgeInsets())
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    // 1. 임시 데이터 생성
    let user = User(
        id: "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
        isActive: true,
        name: "Gale Dyer",
        age: 28,
        company: "Cemention",
        email: "galedyer@cemention.com",
        address: "652 Gatling Place, Kieler, Arizona, 1705",
        about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
        registered: Date.now,
        
        tags: [
            "irure",
            "labore",
            "et",
            "sint",
            "velit",
            "mollit",
            "et"
        ],
        
        
        friends: [
            Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6292", name: "Daisy Bond"),
            Friend(id: "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9", name: "Tanya Roberson")
        ]
    )
    
    // 2. 뷰 리턴
    return NavigationStack {
        UserDetailView(user: user)
    }
}


