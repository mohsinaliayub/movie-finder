//
//  HomeView.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 28.07.24.
//

import SwiftUI

struct HomeView: View {
    var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 4) {
                ForEach(viewModel.trendingMovies) { movie in
                    MoviePosterView(for: movie)
                        .frame(width: 120)
                }
            }
        }
        .padding()
        .task {
            await viewModel.fetchMovies()
        }
    }
}

struct MoviePosterView: View {
    let movie: MovieOverview
    
    var body: some View {
        AsyncImage(url: posterURL()) { poster in
            poster
                .resizable()
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    init(for movie: MovieOverview) {
        self.movie = movie
    }
    
    private func posterURL() -> URL? {
        guard let posterPath = movie.posterPath else { return nil }
        
        let posterURLString = Constants.ApiConstants.baseURLForImage + posterPath
        return URL(string: posterURLString)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
