//
//  CompositionRoot.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

/// Simplified dependency injection container
///
/// Use computed var to get new instances instead of singleton
///
/// Use private for dependencies that should be injected inside CompositionRoot, not accessed directly
enum CompositionRoot {
    
    // UI
    static let userListView = UserListView()
    
    // Datastores
    static var userStore: UserStore { UserStore(service: ghService) }
    
    // Services
    private static let ghService = GitHubService(ghApiURL)
    
    // Config
    private static let ghApiURL = Config.ghApiURL
}
