//
//  YouTubeService.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 2/10/25.
//

import Foundation

struct YouTubeService: HTTPClient {
    let session: URLSession = .shared
    
    // Fetches videos from a specific channel.
    func fetchVideos(channelId: String, maxResults: Int = 20) async -> Result<YouTubeResponse, RequestError> {
        return await sendRequest(endpoint: YouTubeEndpoint.searchVideos(channelId: channelId, maxResults: maxResults),
                                 responseModel: YouTubeResponse.self,
                                 session: session)
    }
    
    // Fetches detailed information for a specific video.
    func fetchVideoDetails(videoId: String) async -> Result<VideoDetailsResponse, RequestError> {
        return await sendRequest(endpoint: YouTubeEndpoint.videoDetails(videoId: videoId),
                                 responseModel: VideoDetailsResponse.self,
                                 session: session)
    }
}
