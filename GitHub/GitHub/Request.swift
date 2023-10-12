//
//  GitHubRequest.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

extension GitHubService {
    struct Request<T: Decodable> {
        var api: API
    }
}

extension GitHubService.Request {
    enum API {
        case allUsers
        case searchUsers(_ query: String)
    }
    
    static func allUsers() -> GitHubService.Request<[User]> {
        GitHubService.Request<[User]>(api: .allUsers)
    }
    
    static func searchUsers(_ query: String) -> GitHubService.Request<GitHubService.Response.SearchResults<User>> {
        GitHubService.Request<GitHubService.Response.SearchResults<User>>(api: .searchUsers(query))
    }
}

extension GitHubService.Request {
    var path: String {
        // 💡 Swift 5.9 return switch as value
        switch api {
        case .allUsers: "users"
        case .searchUsers: "search/users"
        // ❗️ Don't implement default, make compilar warn us if new case added
        }
    }
    
    var parameters: [String : String]? {
        switch api {
        case .allUsers: nil
        case .searchUsers(let query): [
            "q" : query
        ]
        }
    }
    
    var body: Data? {
        // Convert parameters to json dict then use JSONSerialization.data(withJSONObject: )
        switch api {
        case .allUsers: nil
        case .searchUsers: nil
        }
    }
    
    var method: String {
        switch api {
        // GET
        case .allUsers: fallthrough
        case .searchUsers: return "GET"
        // POST
        // ...
        // PUT
        // ...
        }
    }
}
