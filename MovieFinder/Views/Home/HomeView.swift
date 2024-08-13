//
//  HomeView.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 28.07.24.
//

import SwiftUI
import TmdbApi

struct HomeView: View {
    var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            trendingMovies
            Spacer()
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
    
    var trendingMovies: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Trending Now")
                    .font(.title2)
                Spacer()
                Button("See all") { }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: DrawableConstants.posterSpacing) {
                    ForEach(viewModel.indices, id: \.self) { index in
                        MoviePosterView(for: viewModel.getMovie(at: index))
                            .frame(width: DrawableConstants.posterViewWidth)
                    }
                }
                .fixedSize()
            }
        }
        .padding()
    }
    
    private enum DrawableConstants {
        static let posterViewWidth: CGFloat = 120
        static let posterSpacing: CGFloat = 8
    }
}

struct MoviePosterView: View {
    let movie: MovieOverview
    
    var body: some View {
        AsyncImage(url: movie.posterPath) { poster in
            poster
                .resizable()
        } placeholder: {
            RoundedRectangle(cornerRadius: DrawableConstants.cornerRadius)
        }
        .aspectRatio(DrawableConstants.aspectRatio, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: DrawableConstants.cornerRadius))
    }
    
    init(for movie: MovieOverview) {
        self.movie = movie
    }
    
    private enum DrawableConstants {
        static let aspectRatio: CGFloat = 2/3
        static let cornerRadius: CGFloat = 8
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repository: TmdbTrendingMovies()))
}

extension MovieOverview: Identifiable { }
