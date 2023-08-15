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

class GetUserTemporaryToken {
    typealias TokenCompletion = (String?) -> Void

    func getToken(completion: @escaping TokenCompletion) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(DefaultValuesString.mainToken.localized)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "\(DefaultValuesString.mainUrl.localized)\(DefaultValuesString.authenticationTokenNew.localized)")! as URL,
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
                        completion(requestToken)
                    } else {
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
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
        
        let url = URL(string: "\(DefaultValuesString.mainUrl.localized)\(DefaultValuesString.authenticationValidatelogin.localized)\(DefaultValuesString.mainApiKey.localized)")!
        
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
                        print(error)
                        completion(false)
                    }
                }
            }
            task.resume()
        } catch {
            print(error)
            completion(false)
        }
    }
}

