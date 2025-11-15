//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by junseopLee on 11/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tapped = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    
    @State private var isGameOver = false
    
    @State private var score = 0
    @State private var qNumber = 0
    
    var body: some View {
        ZStack {
//            LinearGradient(colors: [.white, .mint], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            Color.mint.ignoresSafeArea()
            
            VStack {
                HStack(alignment: .bottom) {
                    Text("Guess the Flag")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.default.weight(.semibold))
                }
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.gray)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                           flagTapped(number)
                        } label: {
                            Image(countries[number]).clipShape(.capsule).shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: 840)
                    .padding(.vertical, 30)
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(radius: 5)
                
            }.padding()
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            if isGameOver {
                Button("Restart?") {
                    restartGame()
                }
            }
            else {
                Button("Continue") {
                    askQuestion()
                }
            }
        } message: {
          Text(alertMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        tapped = number
        qNumber += 1
        
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            alertMessage = "Your score is \(score)"
            
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Wrong! That’s the flag of \(countries[tapped])"
        }
        
        if qNumber == 8 {
            isGameOver = true
            scoreTitle = "Game Over"
            alertMessage = "Your final score is \(score)"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        score = 0
        qNumber  = 0
        isGameOver = false
        askQuestion()
    }
}

#Preview {
    ContentView()
}
