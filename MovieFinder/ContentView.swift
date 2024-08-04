//
//  ContentView.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 28.07.24.
//

import SwiftUI

extension String: Error {
    
}

struct ContentView: View {
    private let apiKey = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
//                try await downloadGenres()
                try await downloadTrendingMovies()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func downloadGenres() async throws {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        if (response as? HTTPURLResponse)?.statusCode != 200 { throw "response is not 200" }
        let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
        print(genreResponse.genres.prefix(4))
    }
    
    private func downloadTrendingMovies() async throws {
        let urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        if (response as? HTTPURLResponse)?.statusCode != 200 { throw "response is not 200" }
        let result = try JSONDecoder().decode(MovieOverviewResult.self, from: data)
        print(result.results.prefix(4))
    }
}

#Preview {
    ContentView()
}
