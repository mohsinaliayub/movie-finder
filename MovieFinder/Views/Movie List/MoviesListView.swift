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
                ForEach(dataSource.indices, id: \.self) { index in
                    MoviePreview(movie: dataSource.fetchMovie(at: index))
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .task {
            do {
                try await dataSource.fetchMovies()
            } catch {
                
            }
        }
    }
    
    private var columns: [GridItem] {
        [GridItem(), GridItem()]
    }
}

struct MoviePreview: View {
    let movie: MovieOverview
    
    var body: some View {
        VStack(alignment: .leading) {
            poster
        }
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        return formatter
    }()
    
    var poster: some View {
        AsyncImage(url: movie.posterPath) { poster in
            poster
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}


#Preview {
    MoviesListView(dataSource: MoviesListViewModel(repository: InMemoryTrendingMoviesRepository()))
}
