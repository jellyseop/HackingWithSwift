//
//  MissionView.swift
//  Moonshot
//
//  Created by junseopLee on 11/28/25.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Missing \(member.name)")
            }
            
            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.vertical)
                
                Text(mission.formattedDate).font(.title.bold())
                
                VStack(alignment: .leading) {
                    CustomDivider()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    CustomDivider()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }.padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack(alignment: .top, spacing: 30) {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 152)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundStyle(
                                                .white.opacity(0.5)
                                            )
                                    }.padding([.top, .trailing])
                                }.padding(.horizontal)
                                    .containerRelativeFrame(.horizontal)
                            }
                        }
                    }.padding(.top)
                }.scrollTargetBehavior(.paging)
            }.padding(.bottom)
        }.navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
