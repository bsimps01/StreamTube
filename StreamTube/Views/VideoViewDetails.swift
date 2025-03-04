//
//  VideoViewDetails.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 3/3/25.
//

import SwiftUI

struct VideoDetailView: View {
    let video: Video
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: video.thumbnailURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Text(video.title)
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.bottom, 2)
                
                Text(video.description)
                    .font(.body)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("Video Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
