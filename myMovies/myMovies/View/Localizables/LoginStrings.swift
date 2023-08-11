//
//  LoginStrings.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import Foundation

enum LoginStrings: String {
    case usernamePlaceholder
    case passwordPlaceholder
    case loginButton
    case errorLoginMessage
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
