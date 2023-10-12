//
//  User Model.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

struct User: Decodable, Equatable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
    
    var name: String?
    
    // Add init with default params to simplify creating test objects
    // 💡 control + m to spread function arguments onto new lines (XC 15)
    init(
        login: String,
        id: Int = Int.random(in: 1 ... 10000000),
        nodeId: String = "",
        avatarUrl: String = "",
        gravatarId: String = "",
        url: String = "",
        htmlUrl: String = "",
        followersUrl: String = "",
        followingUrl: String = "",
        gistsUrl: String = "",
        starredUrl: String = "",
        subscriptionsUrl: String = "",
        organizationsUrl: String = "",
        reposUrl: String = "",
        eventsUrl: String = "",
        receivedEventsUrl: String = "",
        type: String = "",
        siteAdmin: Bool = false,
        name: String? = ""
    ) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.avatarUrl = avatarUrl
        self.gravatarId = gravatarId
        self.url = url
        self.htmlUrl = htmlUrl
        self.followersUrl = followersUrl
        self.followingUrl = followingUrl
        self.gistsUrl = gistsUrl
        self.starredUrl = starredUrl
        self.subscriptionsUrl = subscriptionsUrl
        self.organizationsUrl = organizationsUrl
        self.reposUrl = reposUrl
        self.eventsUrl = eventsUrl
        self.receivedEventsUrl = receivedEventsUrl
        self.type = type
        self.siteAdmin = siteAdmin
        
        self.name = name
    }
}
