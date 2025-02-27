//
//  Endpoint.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 2/10/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "youtube.googleapis.com" } 
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: [String: Any]? { nil }
    
    func makeURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        
        if let body = body, method == .post || method == .put {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}
