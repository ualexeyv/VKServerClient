//
//  NetworkViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit

class APIService {

    
    let apiKey = Session.shared.token
  
    func APIRequest (extraPath: String, userId: String, searchGroup: String, completion: @escaping (Any) -> Void ) {
        
        let session = URLSession(configuration: .default)
        let path = "/method/" + extraPath
        var urlConstractor = URLComponents()
        urlConstractor.scheme = "https"
        urlConstractor.host = "api.vk.com"
        urlConstractor.path = path
        urlConstractor.queryItems = [
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: apiKey),
            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.130"),
            URLQueryItem(name: "owner_id", value: userId),
            URLQueryItem(name: "q", value: searchGroup)
        ]
        guard let url = urlConstractor.url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
    //    NetworkLogger.log(request: request)
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
       //     NetworkLogger.log(response: response as! HTTPURLResponse, data: data, error: error)
            guard let data = data else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            completion(json)
        })
        task.resume()
        
        
    }
}
