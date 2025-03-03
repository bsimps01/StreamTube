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
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search YouTube", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                            Button("Search") {
                                viewModel.searchVideos()
                                    }
                                }
                            .padding()
                                
                    if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                                .foregroundColor(.red)
                                .padding()
                            }
                                
                List(viewModel.videos) { video in
                    VStack(alignment: .leading) {
                        Text(video.title)
                            .font(.headline)
                        Text(video.description)
                            .font(.subheadline)
                            .lineLimit(2)
                                }
                            .padding(.vertical, 4)
                            }
                        .listStyle(PlainListStyle())
                            }
            .navigationTitle("YouTube Videos")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
