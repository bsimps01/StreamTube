//
//  YouTubeEndpoint.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 2/10/25.
//

import Foundation

enum YouTubeEndpoint: Endpoint {
    case searchVideos(query: String, maxResults: Int)
    case videoDetails(videoId: String)
    
    // Override the host to match your service name.
    var host: String {
        return "youtube.googleapis.com"
    }
    
    var path: String {
        switch self {
        case .searchVideos:
            return "/youtube/v3/search"
        case .videoDetails:
            return "/youtube/v3/videos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchVideos(let query, let maxResults):
            return [
                URLQueryItem(name: "key", value: youTubeApiKey),
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "part", value: "snippet"),
                URLQueryItem(name: "maxResults", value: "\(maxResults)"),
                URLQueryItem(name: "type", value: "video") // Ensure only videos are returned.
            ]
        case .videoDetails(let videoId):
            return [
                URLQueryItem(name: "key", value: youTubeApiKey),
                URLQueryItem(name: "id", value: videoId),
                URLQueryItem(name: "part", value: "snippet,contentDetails,statistics")
            ]
        }
    }
}
