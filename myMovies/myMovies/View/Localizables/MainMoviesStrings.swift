//
//  MainMoviesStrings.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import Foundation

enum MainMoviesStrings: String {
    case mainMoviesTitle
    case popular
    case topRated
    case onTv
    case airingToday
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
