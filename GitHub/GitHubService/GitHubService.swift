//
//  GitHubService.swift
//  GitHub
//
//  Created by Ryan Forsyth on 2023-10-12.
//

import Foundation

final class GitHubService {
    private let baseUrl: String
    private let decoder = JSONDecoder()
    init(_ baseUrl: String) {
        self.baseUrl = baseUrl
        decoder.keyDecodingStrategy = .convertFromSnakeCase // ‼️ GH json keys use snake case
    }
    
    private var authorizedHeader: [String : String] { get async throws {
        // 💡 Here we could check if our API access token is expired, refresh if necessary
        // then return header dict with access token injected (OAuth refresh flow).
        // For the purposes of this project the access token is hardcoded in the config file
        return ["Authorization" : "Bearer \(Config.ghAccessToken)"]
    }}
    
    @discardableResult
    public func get<T: Decodable>(_ request: Request<T>) async throws -> T {
        try await fetchData(from: authorized(request))
    }
    
    private func fetchData<T: Decodable>(from request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        let responseCode = (response as! HTTPURLResponse).statusCode
        guard responseCode == 200 else {
            throw Error.genericErrorWithCode(responseCode)
        }
        do {
            let decodedObject = try decoder.decode(T.self, from: data)
            return decodedObject
        } catch {
            throw Error.decodingError
        }
    }
    
    private func authorized<T>(_ request:Request<T>) async throws -> URLRequest {
        let urlWithPath = URL(string: baseUrl + "/" + request.path)!
        var components = URLComponents(url: urlWithPath, resolvingAgainstBaseURL: false)!
        components.queryItems = request.parameters?.map { URLQueryItem(name: $0, value: $1) }
        
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpBody = request.body
        urlRequest.httpMethod = request.method
        urlRequest.allHTTPHeaderFields = try await authorizedHeader
        
        return urlRequest
    }
}

extension GitHubService: UserAccessing {
    func allUsers() async throws -> [DisplayableUser] {
        let response = try await get(.allUsers())
        let displayables = response.map(\.displayable)
        return displayables
    }
    
    func searchForUsers(with query: String) async throws -> [DisplayableUser] {
        let response = try await get(.searchUsers(query))
        let displayables = response.items.map(\.displayable)
        return displayables
    }
}

extension GitHubService {
    enum Error: LocalizedError {
        case genericErrorWithCode(Int)
        case decodingError
        
        var errorDescription: String? {
            switch self {
            case .genericErrorWithCode(let code): return "Server returned code \(code) 👀"
            case .decodingError: return "Unable to interpret server response 😵"
            }
        }
    }
}
