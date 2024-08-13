//
//  MoviesListView.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import SwiftUI
import TmdbApi

struct MoviesListView: View {
    var dataSource: MoviesListViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(dataSource.movies) { movie in
                    Text(movie.title)
                }
            }
        }
        .task {
            do {
                try await dataSource.fetchMovies()
            } catch {
                
            }
        }
    }
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 120))]
    }
}


#Preview {
    MoviesListView(dataSource: MoviesListViewModel(repository: InMemoryTrendingMoviesRepository()))
}
