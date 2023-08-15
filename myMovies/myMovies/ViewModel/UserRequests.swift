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


class GetUserTemporaryToken {
    typealias TokenCompletion = (String?) -> Void

    func getToken(completion: @escaping TokenCompletion) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYjYyMzhkMjI4YWEyOTNlNmJlYTUyMjI5NjZmOGRiZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lftAWbeir1eBdZ9DAYqsBNx5wL4rL1PpNhlfuzeqh7E"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/authentication/token/new")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseOne = try decoder.decode(RequestToken.self, from: data)
                    
                    if let requestToken = responseOne.requestToken {
                        print("Request Token: \(requestToken)")
                        completion(requestToken)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                print("No data received")
                completion(nil)
            }
        }
        task.resume()
    }
}


class ValidateTemporaryToken {
    typealias TokenCompletion = (String?) -> Void

    func validateToken(tempToken: String) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYjYyMzhkMjI4YWEyOTNlNmJlYTUyMjI5NjZmOGRiZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lftAWbeir1eBdZ9DAYqsBNx5wL4rL1PpNhlfuzeqh7E"
        ]

        print("https://www.themoviedb.org/authenticate/\(tempToken)")
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.themoviedb.org/authenticate/\(tempToken)/")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    
                    let responseOne = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print("responseOne \(responseOne)")
                    
                    
//                    let decoder = JSONDecoder()
//                    let responseOne = try decoder.decode(RequestToken.self, from: data)
//
//                    if let requestToken = responseOne.requestToken {
//                        print("Request Token: \(requestToken)")
//                        completion(requestToken)
//                    } else {
//                        completion(nil)
//                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    //completion(nil)
                }
            } else {
                print("No data received")
                //completion(nil)
            }
        }
        task.resume()
    }
}


class AuthenticationManager {
    typealias CompletionHandler = (Bool) -> Void
    
    func validateRequestTokenWithLogin(username: String, password: String, requestToken: String, completion: @escaping CompletionHandler) {
        let headers = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=cb6238d228aa293e6bea5222966f8dbd")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let body: [String: Any] = [
            "username": username,
            "password": password,
            "request_token": requestToken
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(false)
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseOne = try decoder.decode(RequestToken.self, from: data)
                        let isSuccess = responseOne.success
                        completion(isSuccess ?? false)
                    } catch {
                        print("Error login decoding JSON: \(error)")
                        completion(false)
                    }
                }
            }
            task.resume()
        } catch {
            print("Error login encoding JSON: \(error)")
            completion(false)
        }
    }
    
    

}
