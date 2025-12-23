//
//  UserDTO.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//

import Foundation

struct UserDTO: Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [FriendDTO]
}
