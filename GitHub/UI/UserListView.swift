//
//  UserListView.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import SwiftUI

struct UserListView: View {
    
    @EnvironmentObject private var userStore: UserStore
    
    @State private var showSortOptions = false
    @State private var searchText = ""
    
    @State var navigatedToDetail = false
    
    private var errorAlertText: String {
        "Error occurred: \n\(userStore.loadError?.localizedDescription ?? "Unknown")"
    }
    
    var body: some View {
        ZStack {
            if !userStore.users.isEmpty {
                userList
            } else {
                emptyView
            }
        }
        .task {
            // Don't reload needlessly when coming back from detail view
            if !navigatedToDetail {
                await userStore.load()
            }
            navigatedToDetail = false
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Users")
        .toolbar { sortButton }
        .alert(
            errorAlertText,
            isPresented: Binding(get: { userStore.loadError != nil }, set: { _ in }),
            actions: {
                Button("Try again") {
                    userStore.loadError = nil
                    Task { await userStore.load() }
                }
        })
        .confirmationDialog("Sort by", isPresented: $showSortOptions, titleVisibility: .visible) {
            ForEach(UserStore.SortOrder.allCases, id: \.self) { order in
                Button(order.rawValue.capitalized) {
                    userStore.sortUsers(order)
                }
            }
        }
    }
    
    private var userList: some View {
        List(Binding($userStore.searchedUsers) ?? $userStore.users, id: \.id) { user in
            NavigationLink(destination: {
                // Mock detail view...
                Text("User detail view").onAppear {
                    navigatedToDetail = true
                }
            }, label: {
                UserListCellView(user: user)
            })
        }
        .animation(.default, value: userStore.users)
        .animation(.default, value: userStore.searchedUsers)
        .refreshable {
            await userStore.load()
        }
        .searchable(text: $searchText, prompt: "Search all of GitHub")
        .onChange(of: searchText) { _, newQuery in
            #warning("Searching should be debounced")
            Task {
                await userStore.searchUsers(newQuery)
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView().controlSize(.large)
            Text("Loading users...")
        }
    }
    
    private var emptyView: some View {
        VStack {
            if userStore.isLoading {
                ProgressView()
            }
            Text("List is empty")
        }
    }
    
    private var sortButton: some ToolbarContent {
        ToolbarItem(placement: .automatic) {
            Button("Sorted By \(userStore.sortOrder.rawValue.capitalized)") {
                showSortOptions = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserListView()
            .environmentObject(UserStore(service: StubGitHubService()))
    }
}
