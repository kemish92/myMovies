//
//  AlertStrings.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import Foundation

enum AlertStrings: String {
    case profileActionTitle
    case profile
    case logOut
    case cancel
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
