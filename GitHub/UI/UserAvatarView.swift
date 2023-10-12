//
//  UserAvatarView.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import SwiftUI

struct UserAvatarView: View {
    var imageUrl: String?
    var fallbackImage = Image(systemName: "person.crop.circle.badge.exclamationmark") // Default
    var contentMode: ContentMode = .fill
    
    var body: some View {
        ZStack {
            if let imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { state in
                    if let image = state.image {
                        image.resizable()
                    } else if state.error != nil {
                        fallbackImage.resizable()
                    } else {
                        ProgressView().fullWidthAndHeight()
                    }
                }
            } else {
                fallbackImage.resizable()
            }
        }
        // Scale to fill parent frame and clip with circle
        .aspectRatio(contentMode: contentMode)
        .overlay(Circle().strokeBorder(LinearGradient.ghColors, lineWidth: 2))
        .clipShape(Circle())
        .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UserAvatarView(imageUrl: "https://avatars.githubusercontent.com/u/45875515?v=4")
        .padding()
        .frame(width: 200, height: 200)
}
