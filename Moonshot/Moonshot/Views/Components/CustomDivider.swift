//
//  Divider.swift
//  Moonshot
//
//  Created by junseopLee on 11/28/25.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    Divider()
}
