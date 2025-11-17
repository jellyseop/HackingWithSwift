//
//  ContentView.swift
//  Day25_Challenge
//
//  Created by junseopLee on 11/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["✌️", "🖐️", "✊"].shuffled()
    @State private var current_move = Int.random(in: 0...2)
    
    @State private var shoudWin = Bool.random()
    @State private var score = 0
    
    var body: some View {
        ZStack {
            Color.mint.ignoresSafeArea()
            VStack {
                VStack(spacing: 70) {
                    VStack {
                        Text("\"\(moves[current_move])\"").font(.largeTitle)
                        HStack(alignment: .bottom) {
                            Text("You shoud").font(.headline)
                            Text(shoudWin ? "WIN" : "LOSE").font(.title2.weight(.bold))
                        }
                    }
                    
                    HStack(spacing: 30) {
                        ForEach(0 ..< 3) { number in
                            Button {} label: {
                                Text(moves[number]).font(.largeTitle)
                            }.padding()
                        }
                    }.frame(maxWidth: .infinity)
                }
                .padding(.vertical, 70)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 10)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
