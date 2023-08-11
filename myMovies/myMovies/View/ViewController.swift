//
//  ViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODZkNjI2NjUyYjE4ZmEzMWYwYWMzNzAwMTcyOTU1ZCIsInN1YiI6IjY0ZDU4NTE2YjZjMjY0MTE1OTU4NjY1YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Pl2WO9DVrKueT-tdJKghqJ96FuguDRrgPoj2PhTcr4M"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")! as URL,
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
                    print("Error")
                }
            } else {
                print("An error occurred \(error)")
            }
        }
        task.resume()
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//          if (error != nil) {
//            print(error as Any)
//          } else {
//            let httpResponse = response as? HTTPURLResponse
//            print(httpResponse)
//          }
//        })
//
//        dataTask.resume()
        // Do any additional setup after loading the view.
    }


}

