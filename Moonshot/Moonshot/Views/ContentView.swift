//
//  ContentView.swift
//  Moonshot
//
//  Created by junseopLee on 11/26/25.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showList = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                if showList {
                    ListLayout(missions: missions, astronauts: astronauts)
                } else {
                    GridLayout(missions: missions, astronauts: astronauts)
                }
            }.navigationTitle("Moonshot")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
                .navigationDestination(for: Astronaut.self) { astronaut in
                    AstronautView(astronaut: astronaut)
                }
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button(showList ? "Grid" : "List") {
                            showList.toggle()
                        
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
