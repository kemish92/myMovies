//
//  MovieDetailsViewModel.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

class MovieDetailsViewModel {
    var allMoviesDetails: MovieDetailsModel?
    var apiService = MovieDetails.shared

    func fetchMovies(id: Int, completion: @escaping (MovieDetailsModel) -> Void) {
        apiService.apiRequest(id: id) { [weak self] activeData in
            self?.allMoviesDetails = activeData
            DispatchQueue.main.async {
                completion(activeData)
            }
        }
    }
}
