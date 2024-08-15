//
//  MovieDetailsView.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 14.08.24.
//

import SwiftUI
import TmdbApi

struct MovieDetailsView: View {
    var dataSource: MovieDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let movie = dataSource.movie {
                    MovieDetailsPreview(movie: movie)
                } else {
                    Text("Fetching movie...")
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .task {
            await dataSource.fetchMovieDetails()
        }
        .overlay(alignment: .topLeading) {
            backButton
                .padding(.horizontal)
                .hidden()
        }
    }
    
    var backButton: some View {
        Button(action: { }) {
            Image(systemName: "arrow.backward.circle.fill")
                .resizable()
        }
        .frame(width: 48, height: 48, alignment: .topLeading)
        .foregroundStyle(.separator)
    }
}

struct MovieDetailsPreview: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
            poster
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.semibold)
//                    imdbRating
                    genres.padding(.top, 8)
                    synopsis.padding(.top)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Top Cast").font(.title.bold())
                        cast
                    }
                    .padding(.vertical, 4)
                }
                .padding()
                .background {
                    LinearGradient(colors: [.white.opacity(0.95), .white], startPoint: .top, endPoint: .bottom)
                }
                .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 25, topTrailing: 25)))
            }
        }
    }
    
    var details: some View {
        ScrollView {
            VStack(alignment: .leading) {
                poster
                Group {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    imdbRating
                    genres.padding(.top, 8)
                    synopsis.padding(.top)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Top Cast").font(.title.bold())
                        cast
                    }
                    .padding(.vertical, 4)
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
    }
    
    var poster: some View {
        AsyncImage(url: movie.posterURL) { poster in
            poster.resizable()
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
        }
        .aspectRatio(1/1.4, contentMode: .fit)
    }
    
    var imdbRating: some View {
        Text("IMDB \(String(format: "%.1f", movie.rating))")
            .font(.subheadline)
            .foregroundStyle(.black)
            .fontWeight(.light)
            .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            .background {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.orange)
            }
    }
    
    var genres: some View {
        HStack {
            ForEach(movie.genres, id: \.id) { genre in
                ellipsedText(genre.name)
            }
        }
    }
    
    var cast: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(movie.cast, id: \.id) { cast in
                    VStack(alignment: .leading) {
                        AsyncImage(url: cast.profilePhotoURL) { image in
                            image.resizable()
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 8)
                        }
                        .frame(width: 80, height: 100)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        
                        Text(cast.name)
                            .font(.callout)
                            .lineLimit(1)
                        Text(cast.character)
                            .font(.caption2)
                            .lineLimit(1)
                            .padding(.top, 0)
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 80)
                    .padding(.trailing, 8)
                }
            }
            .fixedSize()
        }
        .scrollIndicators(.hidden)
    }
    
    func ellipsedText(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 55)
                    .foregroundStyle(.bar)
            }
    }
    
    var synopsis: some View {
        Text(movie.synopsis)
            .font(.callout)
            .kerning(1)
    }
}

#Preview {
    MovieDetailsView(
        dataSource: 
            MovieDetailsViewModel(
                movieId: 533535,
                repository: InMemoryMovieDetailRepository()
            )
    )
}
