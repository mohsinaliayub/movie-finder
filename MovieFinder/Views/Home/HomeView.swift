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
            LazyHStack {
                ForEach(viewModel.trendingMovies) { _ in
                    MovieInfoView()
                        .frame(width: 140)
                }
            }
        }
        .padding()
        .task {
            await viewModel.fetchMovies()
        }
    }
}

struct MovieInfoView: View {
    
    var body: some View {
        Image("deadpool")
            .resizable()
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
