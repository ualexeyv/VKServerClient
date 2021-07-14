//
//  NetworkViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit
import Alamofire

class APIService {

    
    let apiKey = Session.shared.token
    let baseUrl = "https://api.vk.com"
    let method = "/method/"
    let groupsExtraPath = "groups.get"
    let friendsExtraPath = "friends.get"
    
    func APIFriendsRequest (completion: @escaping ([User]) -> Void ) {
        
        let session = URLSession(configuration: .default)
        let path = method + friendsExtraPath
        var urlConstractor = URLComponents()
        urlConstractor.scheme = "https"
        urlConstractor.host = "api.vk.com"
        urlConstractor.path = path
        urlConstractor.queryItems = [
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: apiKey),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.130"),
        ]
        
        guard let url = urlConstractor.url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
    //    NetworkLogger.log(request: request)
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
     //       NetworkLogger.log(response: (response as! HTTPURLResponse), data: data, error: error)
            guard let data = data else {return}
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                
                let friendsResponse = try JSONDecoder().decode(Friends.self, from: data)
                
                let friends = friendsResponse.response.items
               
                completion(friends)
            } catch {
                print (error.localizedDescription)
            }
            
        })
        task.resume()
        
        
    }
    //manual parsing
    func APIGroupsRequest (completion: @escaping ([Groups]) -> Void ) {
        
        let url = baseUrl+method+groupsExtraPath
        
        let groupParameters: Parameters = [
            "fields": "photo_50",
            "count": "10",
            "extended": "1",
            "access_token": apiKey,
            "v": "5.130"
        ]
        
        AF.request(url, method: .get, parameters: groupParameters).responseData { response in
            guard let data = response.data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let object = json as! [String: Any]
                let response = object["response"] as! [String: Any]
                let items = response["items"] as! [Any]
                var groups: [Groups] = []
                for item in items {
                    let group = Groups(json: item as! [String : Any])
                    groups.append(group)
                }
                completion(groups)
                
            } catch {
                print (error.localizedDescription)
            }
        }
        
        
    }
    func APIPhotosRequest (extraPath: String, userId: String, searchGroup: String, completion: @escaping ([User]) -> Void ) {
        
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
     //       NetworkLogger.log(response: (response as! HTTPURLResponse), data: data, error: error)
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                
                let friendsResponse = try JSONDecoder().decode(Friends.self, from: data)
                
                let friends = friendsResponse.response.items
                
                completion(friends)
            } catch {
                print (error.localizedDescription)
            }
            
        })
        task.resume()
        
        
    }
}
