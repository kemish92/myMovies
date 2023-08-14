//
//  AllMoviesConnection.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/12/23.
//

import Foundation

class MovieAPI {
    static let shared = MovieAPI()

    func apiRequest(page: Int, completion: @escaping (Movies) -> ()) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYjYyMzhkMjI4YWEyOTNlNmJlYTUyMjI5NjZmOGRiZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lftAWbeir1eBdZ9DAYqsBNx5wL4rL1PpNhlfuzeqh7E"
        ]

        //https://api.themoviedb.org/3/movie/popular?language=en-US&page=1 Popular
        //https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1 Top Rated
        //https://api.themoviedb.org/3/genre/tv/list?language=en-US&page=1
        let request = NSMutableURLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=\(page)")!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    
                    let responseOne = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("responseOne\(responseOne)")

                    
                    
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
