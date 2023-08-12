//
//  ProfileStrings.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import Foundation

enum ProfileStrings: String {
    case profileTitle
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
