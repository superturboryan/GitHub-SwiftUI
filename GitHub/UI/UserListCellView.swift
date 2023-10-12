//
//  UserListCellView.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import SwiftUI

struct UserListCellView: View {
    
    @Binding var user: User
    
    var body: some View {
        HStack {
            UserAvatarView(imageUrl: user.avatarUrl)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(user.login)
                    .font(.headline)
                if let name = user.name, !name.isEmpty {
                    Text(name)
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .fullWidth(.leading)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UserListCellView(user: .constant(testUser()))
        .frame(width: 300, height: 100)
}
