//
//  Request.swift
//  
//
//  Created by Major League Digital on 16/8/21.
//

import Foundation

public protocol Request {
    var scheme: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var host: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}
public extension Request {
    var scheme: String { return "https" }
    var method: HTTPMethod { return .get }
    var headers: [String: String] { return [:] }
    var body: Data? { return nil }
    
    func build() -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host   = host
        components.path   = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod          = method.rawValue
        request.httpBody            = body
        
        return request
    }
}
