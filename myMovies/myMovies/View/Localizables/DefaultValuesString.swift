//
//  DefaultValuesString.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/14/23.
//

import Foundation

enum DefaultValuesString: String {
    case defaultLogoLogin
    case defaultImage
    case defaultImageGradient
    case defaultRateIcon
    case defaultFont
    case defaultShow
    case defaultSection
    case defaultMovie
    case defaultTv
    case urlImages
    case apiEndpointPopular
    case apiEndpointTopRated
    case apiEndpointOnTheAir
    case apiEndpointAiringToday
    case mainUrl
    case mainLanguage
    case mainToken
    case mainApiKey
    case continueAsGuest
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
