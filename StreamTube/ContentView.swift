//
//  ContentView.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    // Observe the view model.
    @StateObject private var viewModel = YouTubeViewModel()
    
    // Replace with your desired channel ID.
    let channelId = "@Benjamin5311"
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
                List(viewModel.videos) { video in
                    VStack(alignment: .leading) {
                        Text(video.title)
                            .font(.headline)
                        Text(video.description)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("YouTube Videos")
            .onAppear {
                viewModel.fetchVideos(channelId: channelId)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
