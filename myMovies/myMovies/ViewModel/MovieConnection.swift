//
//  MovieConnection.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

class MovieDetails {
    static let shared = MovieDetails()

    func apiRequest(showType: String, id: Int, completion: @escaping (MovieDetailsModel) -> ()) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(DefaultValuesString.mainToken.localized)"
        ]

        let request = NSMutableURLRequest(url: URL(string: "\(DefaultValuesString.mainUrl.localized)\(showType)/\(id)\(DefaultValuesString.mainApiKey.localized)")!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let parsingData = try decoder.decode(MovieDetailsModel.self, from: data)
                    completion(parsingData)
                } catch {
                    print("\(error)")
                }
            } else {
                print("\(error)")
            }
        }
        task.resume()
    }
}

