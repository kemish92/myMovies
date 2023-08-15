//
//  AddFavouriteViewModel.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/15/23.
//

import Foundation

class AddFavouriteViewModel {
    func addFav(favId: Int){
        let headers = [
          "accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYjYyMzhkMjI4YWEyOTNlNmJlYTUyMjI5NjZmOGRiZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lftAWbeir1eBdZ9DAYqsBNx5wL4rL1PpNhlfuzeqh7E"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/account/20286039/favorite")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let parameters = [
          "media_type": "movie",
          "media_id": 569094,
          "favorite": true
        ] as [String : Any]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseOne = try decoder.decode(RequestToken.self, from: data)
                        let isSuccess = responseOne.success
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        } catch {
            print(error)
        }
    }
}


//{
//"success": true,
//"status_code": 12,
//"status_message": "The item/record was updated successfully."
//}
