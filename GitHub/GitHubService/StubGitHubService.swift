//
//  StubGitHubService.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

struct StubGitHubService {
    var shouldThrowError = false
    var shouldReturnEmptyUsers = false
}

extension StubGitHubService: UserAccessing {
    func allUsers() async throws -> [DisplayableUser] {
        if shouldThrowError { throw StubError.stub }
        let users: [GitHubService.Response.User] = [
            testUser(),
            testUser(),
            testUser(),
            testUser(),
            testUser(),
        ]
        return shouldReturnEmptyUsers ? [] : users.map(\.displayable)
    }
    
    func searchForUsers(with query: String) async throws -> [DisplayableUser] {
        if shouldThrowError { throw StubError.stub }
        return shouldReturnEmptyUsers ? [] : [
            testUser(query).displayable
        ]
    }
}

extension StubGitHubService {
    enum StubError: LocalizedError {
        case stub
        
        var errorDescription: String? {
            switch self {
            case .stub: return "Stub error 🫨"
            }
        }
    }
}

func testUser(_ named: String? = nil) -> GitHubService.Response.User {
    let id = Int.random(in: 1 ... 1000000)
    return GitHubService.Response.User(
        login: named ?? "username \(id)",
        id: id,
        avatarUrl: "https://avatars.githubusercontent.com/u/45875515?v=4",
        name: "name \(id)"
    )
}
