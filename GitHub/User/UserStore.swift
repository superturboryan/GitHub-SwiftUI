//
//  UserStore.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

protocol UserAccessing {
    func allUsers() async throws -> [DisplayableUser]
    func searchForUsers(with query: String) async throws -> [DisplayableUser]
}

final class UserStore: ObservableObject {
    
    @Published var users: [DisplayableUser] = []
    @Published var searchedUsers: [DisplayableUser]? = nil
    
    @Published private(set) var sortOrder: SortOrder = .id // Initial state
    @Published private(set) var isLoading: Bool = false
    @Published var loadError: Error? = nil

    // Dependencies
    private var service: UserAccessing
    init(service: UserAccessing) {
        self.service = service
    }
    
    @MainActor
    func load() async {
        isLoading = true
        do {
            users = try await service.allUsers()
            sortUsers(sortOrder)
        } catch {
            loadError = error
        }
        isLoading = false
    }
    
    @MainActor
    func searchUsers(_ query: String) async {
        guard !query.isEmpty else {
            searchedUsers = nil
            return
        }
        do {
            searchedUsers = try await service.searchForUsers(with: query)
        } catch {
            loadError = error
        }
    }
    
    func sortUsers(_ order: SortOrder) {
        users = users.sorted(by: {
            switch order {
            case .username:
                return $0.username < $1.username
            case .id:
                return $0.id < $1.id
            case .name:
                guard let first = $0.realName, let second = $1.realName else {
                    return true
                }
                return first < second
            }})
        sortOrder = order
    }
}

extension UserStore {
    enum SortOrder: String, CaseIterable {
        case username = "username"
        case id = "id"
        case name = "name"
    }
}
