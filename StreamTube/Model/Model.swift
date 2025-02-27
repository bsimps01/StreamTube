//
//  Model.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 3/20/24.
//

import Foundation

struct Video: Identifiable, Decodable {
    let id: String
    let title: String
    let description: String
    let thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, snippet
    }
    
    enum IdKeys: String, CodingKey {
        case videoId
    }
    
    enum SnippetKeys: String, CodingKey {
        case title, description, thumbnails
    }
    
    enum ThumbnailsKeys: String, CodingKey {
        case high
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // In search results, "id" is an object with a "videoId" field.
        let idContainer = try container.nestedContainer(keyedBy: IdKeys.self, forKey: .id)
        self.id = try idContainer.decode(String.self, forKey: .videoId)
        
        let snippetContainer = try container.nestedContainer(keyedBy: SnippetKeys.self, forKey: .snippet)
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: ThumbnailsKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailsContainer.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .high)
        self.thumbnailURL = try highContainer.decode(String.self, forKey: .url)
    }
}

/// The top-level response from the YouTube API.
struct YouTubeResponse: Decodable {
    let items: [Video]
}

struct VideoDetailsResponse: Decodable {
    let items: [VideoDetail]
}

struct VideoDetail: Decodable {
    let id: String
    let snippet: VideoSnippet
    let statistics: VideoStatistics
    
    struct VideoSnippet: Decodable {
        let title: String
        let description: String
        let thumbnails: VideoThumbnails
        
        struct VideoThumbnails: Decodable {
            let high: VideoThumbnail
            
            struct VideoThumbnail: Decodable {
                let url: String
            }
        }
    }
    
    struct VideoStatistics: Decodable {
        let viewCount: String
        let likeCount: String?
        let dislikeCount: String?
        let commentCount: String?
    }
}

