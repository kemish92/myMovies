//
//  UserDetailsConnection.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/15/23.
//

import Foundation

class UserAPI {
    static func getUserDetails(username: String, completion: @escaping (String?) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(DefaultValuesString.mainToken.localized)"
        ]

        let url = URL(string: "\(DefaultValuesString.mainAccount.localized)\(username)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let userDetails = try decoder.decode(UserDetails.self, from: data)
                    completion(userDetails.username)
                } catch {
                    print("\(error)")
                    completion(nil)
                }
            } else if let error = error {
                print("\(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}

class ProfileViewModel {
    var carouselMovies: Movies?
    var dataUpdated: (() -> Void)?
    func fetchProfileData(username: String) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(DefaultValuesString.mainToken.localized)"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(DefaultValuesString.mainAccount.localized)\(username)\(DefaultValuesString.mainFavorite.localized)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let parsingData = try decoder.decode(Movies.self, from: data)
                    self.carouselMovies = parsingData
                    DispatchQueue.main.async {
                        self.dataUpdated?()
                    }
                } catch {
                    print("\(error)")
                }
            } else {
                print("\(error)")
            }
        }
        task.resume()
    }
    
    func getNumberOfCarouselItems() -> Int {
        return carouselMovies?.results?.count ?? 0
    }
}



