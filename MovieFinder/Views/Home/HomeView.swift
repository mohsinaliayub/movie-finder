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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
