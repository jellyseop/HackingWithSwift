//
//  Friends.swift
//  day60_challenge
//
//  Created by junseopLee on 12/23/25.
//

import Foundation
import SwiftData

@Model
class Friend {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
