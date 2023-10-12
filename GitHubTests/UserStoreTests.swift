//
//  UserStoreTests.swift
//  GitHubTests
//
//  Created by Ryan Forsyth on 2023-10-12.
//

@testable import GitHub
import XCTest

final class UserStoreTests: XCTestCase {

    // System under test
    var sut: UserStore!
    
    // Dependencies
    var stubService = StubGitHubService()
    
    func testUserStore_load_serviceReturnsUsers() async {
        // Given a service that returns users
        stubService.shouldReturnEmptyUsers = false
        stubService.shouldThrowError = false
        sut = UserStore(service: stubService)
        // When
        await sut.load()
        // Then
        XCTAssertFalse(sut.users.isEmpty)
        XCTAssertNil(sut.loadError)
    }
    
    func testUserStore_load_serviceThrowsError() async {
        // Given a service that throws an error
        stubService.shouldThrowError = true
        sut = UserStore(service: stubService)
        // When
        await sut.load()
        // Then
        XCTAssertNotNil(sut.loadError)
    }
    
    func testUserStore_load_serviceReturnsEmptyUsers() async {
        // Given a service that returns an empty array of users
        stubService.shouldReturnEmptyUsers = true
        stubService.shouldThrowError = false
        sut = UserStore(service: stubService)
        // When
        await sut.load()
        // Then
        XCTAssertTrue(sut.users.isEmpty)
    }
    
    func testUserStore_sortUsers() async {
        // Given employee store should sort employees by their name or team
        sut = UserStore(service: stubService)
        await sut.load()
        let sortedByUsername = sut.users.sorted(by: {
            $0.username < $1.username
        })
        let sortedById = sut.users.sorted(by: {
            $0.id < $1.id
        })
        
        // When sorting by username
        sut.sortUsers(.username)
        // Then
        XCTAssertEqual(sut.users, sortedByUsername)
        
        // When sorting by id
        sut.sortUsers(.id)
        // Then
        XCTAssertEqual(sut.users, sortedById)
    }
    
    func testUserStore_searchUsers() async {
        // Given a service that returns employees
        stubService.shouldReturnEmptyUsers = false
        sut = UserStore(service: stubService)
        
        // When searching with a non-empty query
        await sut.searchUsers("query")
        
        // Results are stored in the searchedUsersParam
        XCTAssertNotNil(sut.searchedUsers)
        
        // When searching with an empty query
        await sut.searchUsers("")
        
        XCTAssertNil(sut.searchedUsers)
    }
    
    func testUserStore_searchUsers_serviceThrowsError() async {
        // Given a service that throws an error
        stubService.shouldThrowError = true
        sut = UserStore(service: stubService)
        
        // When searching with a non-empty query
        await sut.searchUsers("query")
        
        // Then
        XCTAssertNotNil(sut.loadError)
    }
}
