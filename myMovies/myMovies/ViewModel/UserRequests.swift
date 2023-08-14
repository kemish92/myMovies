//
//  UserRequests.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

let testingMode = debugController().validator

class loginUserValidator {
    func loginValidator() -> String {
        if testingMode == 0 {
            return "debug_disabled"
        } else if testingMode == 1 {
            return "debug_enabled"
        } else {
            return "error"
        }
    }
}

class loginUser {
    func login(username: String, password: String) {
        
        
        let apiKey = "cb6238d228aa293e6bea5222966f8dbd"
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYjYyMzhkMjI4YWEyOTNlNmJlYTUyMjI5NjZmOGRiZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lftAWbeir1eBdZ9DAYqsBNx5wL4rL1PpNhlfuzeqh7E"
            
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/account/kemish?api_key=\(apiKey)")! as URL,
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
                } catch {
                    print("Error \(error)")
                }
            } else {
                print("An error occurred \(error)")
            }
        }
        task.resume()
        
    }
}
