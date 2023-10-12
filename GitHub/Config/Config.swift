//
//  Config.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

enum Config {
    static let ghApiURL = Bundle.main.object(forInfoDictionaryKey: "GH_API_URL") as! String
    static let ghAccessToken = Bundle.main.object(forInfoDictionaryKey: "GH_ACCESS_TOKEN") as! String
}
