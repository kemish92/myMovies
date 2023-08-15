//
//  LoginModel.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/14/23.
//

import Foundation

struct RequestToken: Codable {
    let expiresAt, requestToken: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case success
    }
}
