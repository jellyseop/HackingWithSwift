//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by junseopLee on 11/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Gryffindor")
                .blur(radius: 3)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .blur(radius: 2)
    }
}

#Preview {
    ContentView()
}
