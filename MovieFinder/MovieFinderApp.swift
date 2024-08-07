//
//  MovieFinderApp.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 28.07.24.
//

import SwiftUI

@main
struct MovieFinderApp: App {
    private let homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: homeViewModel)
        }
    }
}
