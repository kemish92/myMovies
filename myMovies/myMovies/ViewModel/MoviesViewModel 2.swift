//
//  MoviesViewModel.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

class MoviesViewModel {
    var allMovies: Movies?
    var apiService = MovieAPI.shared

    func fetchMovies(page: Int, completion: @escaping () -> Void) {
        apiService.apiRequest(page: page) { [weak self] activeData in
            self?.allMovies = activeData
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func numberOfItems() -> Int {
        return allMovies?.results?.count ?? 0
    }

    func movieAtIndex(_ index: Int) -> Result? {
        return allMovies?.results?[index]
    }
}
