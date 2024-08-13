//
//  Constants.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 11.08.24.
//

import Foundation

enum Constants {
    enum ApiConstants {
        /// The API Key used to make all requests.
        ///
        /// Go to [TMDB](https://themoviedb.org/settings/api) and copy the API Key.
        static let apiKey = "PUT YOUR API KEY HERE"
        
        /// The base URL to access all poster photos. Uses `w500` image size.
        ///
        /// Go to [TMDB Docs](https://developer.themoviedb.org/docs/image-basics) to find out other image sizes available.
        static let baseURLForPoster = "https://image.tmdb.org/t/p/w500"
    }
}
