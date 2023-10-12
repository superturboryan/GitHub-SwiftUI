//
//  User Model.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

struct DisplayableUser: Equatable {
    let id: Int
    let username: String
    let realName: String?
    let avatarUrl: URL?
}

extension GitHubService.Response.User {
    var displayable: DisplayableUser {
        DisplayableUser(
            id: self.id,
            username: self.login,
            realName: self.name,
            avatarUrl: URL(string: self.avatarUrl)
        )
    }
}
