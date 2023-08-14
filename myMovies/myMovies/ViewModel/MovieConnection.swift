//
//  MovieConnection.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

class MovieDetails {
    static let shared = MovieDetails()

    func apiRequest(id: Int, completion: @escaping (MovieDetailsModel) -> ()) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYjYyMzhkMjI4YWEyOTNlNmJlYTUyMjI5NjZmOGRiZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lftAWbeir1eBdZ9DAYqsBNx5wL4rL1PpNhlfuzeqh7E"
        ]

        let request = NSMutableURLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=cb6238d228aa293e6bea5222966f8dbd")!,
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
                    print("parsingData \(parsingData)")
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

