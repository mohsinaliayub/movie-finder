//
//  MovieFinderApp.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 28.07.24.
//

import SwiftUI
import TmdbApi

@main
struct MovieFinderApp: App {
    private let moviesViewModel = MoviesListViewModel(repository: TmdbTrendingMovies())
    
    var body: some Scene {
        WindowGroup {
//            HomeView(viewModel: homeViewModel)
            MoviesListView(dataSource: moviesViewModel)
        }
    }
}
