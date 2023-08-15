//
//  ErrorStrings.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

enum ErrorStrings: String {
    case loadingImageError
    case coderNotImplemented
    case failedToLoadImage
    case invaludURL
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
