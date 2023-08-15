//
//  UserDetails.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/15/23.
//

import Foundation

struct UserDetails: Codable {
    let id: Int?
    let name: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
    }
}
