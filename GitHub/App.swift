//
//  GitHubApp.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-11.
//

import SwiftUI

@main
struct GitHubApp: App {
    
    @StateObject var employeeStore = CompositionRoot.userStore
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CompositionRoot.userListView
                    .environmentObject(employeeStore)
            }
        }
    }
}
