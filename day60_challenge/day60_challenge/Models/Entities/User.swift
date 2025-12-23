//
//  User.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//
import Foundation
import SwiftData

@Model
class User {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]) {
        
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
    convenience init(from dto: UserDTO) {
        let friendModels = dto.friends.map { Friend(id: $0.id, name: $0.name) }
        
        self.init(id: dto.id, isActive: dto.isActive, name: dto.name, age: dto.age, company: dto.company, email: dto.company, address: dto.address, about: dto.about, registered: dto.registered, tags: dto.tags, friends: friendModels)
    }
}
