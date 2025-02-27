//
//  ViewModel.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 2/10/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class YouTubeViewModel: ObservableObject {
    // Published properties so that SwiftUI views can update when data changes.
    @Published var videos: [Video] = []
    @Published var errorMessage: String? = nil
    
    // Instance of the service that handles network requests.
    private let service = YouTubeService()
    
    // Fetches videos for the provided YouTube channel ID.
    func fetchVideos(channelId: String) {
        // Use a Task to call our async method.
        Task {
            let result = await service.fetchVideos(channelId: channelId, maxResults: 20)
            switch result {
            case .success(let response):
                // Assign the returned videos to the published property.
                self.videos = response.items
                self.errorMessage = nil  // Clear any previous error message.
            case .failure(let error):
                // If an error occurs, set the errorMessage.
                self.errorMessage = error.customMessage
                self.videos = []  // Optionally, clear out any previous videos.
            }
        }
    }
    
    // Fetch detailed information for a specific video.
    @Published var selectedVideoDetails: VideoDetail? = nil
    
    func fetchVideoDetails(for videoId: String) {
        Task {
            let result = await service.fetchVideoDetails(videoId: videoId)
            switch result {
            case .success(let response):
                // If multiple details are returned, we pick the first one.
                self.selectedVideoDetails = response.items.first
                self.errorMessage = nil
            case .failure(let error):
                self.errorMessage = error.customMessage
            }
        }
    }
}
