//
//  ListLayout.swift
//  Moonshot
//
//  Created by junseopLee on 11/28/25.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List(missions) {
             mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        ZStack {
                            Color(.lightBackground)
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                        }.frame(width: 120, height: 120)
                            .clipShape(.rect(cornerRadius: 10))
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.vertical, 7)
                            Text(mission.formattedDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                            Spacer()
                        }.padding()
                    }
                }.listRowBackground(Color.darkBackground)
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
        }.listStyle(.plain)
           
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListLayout(missions: missions, astronauts: astronauts).preferredColorScheme(.dark)
}
