//
//  AllMoviesConnection.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

class MovieAPI {
    static let shared = MovieAPI()

    func apiRequest(showType: String, defaultSection: String, page: Int, completion: @escaping (Movies) -> ()) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(DefaultValuesString.mainToken.localized)"
        ]

        let request = NSMutableURLRequest(url: URL(string: "\(DefaultValuesString.mainUrl.localized)\(showType)/\(defaultSection)\(DefaultValuesString.mainLanguage.localized)\(page)")!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    let responseOne = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let decoder = JSONDecoder()
                    let parsingData = try decoder.decode(Movies.self, from: data)
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
