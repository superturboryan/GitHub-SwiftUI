//
//  GitHubResponse.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

// Namespace
extension GitHubService {
    enum Response {}
}

extension GitHubService.Response {
    struct SearchResults<T: Decodable>: Decodable {
        let totalCount: Int
        let incompleteResults: Bool
        let items: [T]
    }
}
