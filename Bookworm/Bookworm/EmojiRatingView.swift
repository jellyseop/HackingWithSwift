//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by junseopLee on 12/11/25.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int

    var body: some View {
        HStack {
            ForEach(0..<rating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundStyle(Color.yellow)
            }
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}
