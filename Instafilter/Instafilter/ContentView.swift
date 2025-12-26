//
//  ContentView.swift
//  Instafilter
//
//  Created by junseopLee on 12/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?.resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = Image(.example)
    }
}

#Preview {
    ContentView()
}
