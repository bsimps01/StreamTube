//
//  VideoView.swift
//  StreamTube
//
//  Created by Benjamin Simpson on 3/3/25.
//

import SwiftUI

struct VideoRow: View {
    let video: Video

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AsyncImage(url: URL(string: video.thumbnailURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 80)
                        .clipped()
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 120, height: 80)
                } else {
                    ProgressView()
                        .frame(width: 120, height: 80)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(video.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(video.description)
                    .font(.subheadline)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
