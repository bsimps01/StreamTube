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
    @Published var searchQuery: String = ""
    @Published var videos: [Video] = []
    @Published var errorMessage: String? = nil
    
    // Instance of the service that handles network requests.
    private let service = YouTubeService()
    
    // Performs a video search based on the current search query.
    func searchVideos() {
        Task {
            let result = await service.fetchVideos(query: searchQuery)
            switch result {
            case .success(let response):
                self.videos = response.items
                self.errorMessage = nil
            case .failure(let error):
                self.errorMessage = error.customMessage
                self.videos = []
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
