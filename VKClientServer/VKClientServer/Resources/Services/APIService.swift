//
//  NetworkViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit
import Alamofire
//import DynamicJSON
import SwiftyJSON

class APIService {

    
    let apiKey = Session.shared.token
    let userId = Session.shared.userId
    let baseUrl = "https://api.vk.com"
    let method = "/method/"
    let groupsExtraPath = "groups.get"
    let friendsExtraPath = "friends.get"
    let photosExtraPath = "photos.getAll"
    let newsExtraPath = "newsfeed.get"
    let usersExtraPath = "users.get"
    
    func APIUsersRequest (completion: @escaping ([UserModel]) -> Void) {
        let url = baseUrl+method+usersExtraPath
        let userParameters: Parameters =
            [ "fields": ["photo_50", "verified"],
              "name_case": "Nom",
              "user_ids": userId,
              "access_token": apiKey,
              "v": "5.130"]
        AF.request(url, method: HTTPMethod.get, parameters: userParameters).responseData { response in
            guard let data = response.data else {return}
            guard let items = JSON(data)["response"].array else {return}
            let userArray = items.map {UserModel(json: $0)}
          
            completion (userArray)
        }
    }
    func APIFriendsRequest (completion: @escaping ([FriendsModel]) -> Void ) {
        
        let session = URLSession(configuration: .default)
        let path = method + friendsExtraPath
        var urlConstractor = URLComponents()
        urlConstractor.scheme = "https"
        urlConstractor.host = "api.vk.com"
        urlConstractor.path = path
        urlConstractor.queryItems = [
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: apiKey),
            URLQueryItem(name: "count", value: "15"),
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
    func APIGroupsRequest (completion: @escaping ([GroupsModel]) -> Void ) {
        
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
                var groups: [GroupsModel] = []
                for item in items {
                    let group = GroupsModel(json: item as! [String : Any])
                    groups.append(group)
                }
                completion(groups)
                
            } catch {
                print (error.localizedDescription)
            }
        }
        
        
    }
    func APIPhotosRequest (ownerId: Int, completion: @escaping ([Photos2]) -> Void ) {
        
        let url = baseUrl+method+photosExtraPath
        
        let groupParameters: Parameters = [
            
            "count": "10",
            "extended": "1",
            "access_token": apiKey,
            "owner_id": ownerId,
            "v": "5.130",
            "skip_hidden": "1",
        ]
        
        AF.request(url, method: .get, parameters: groupParameters).responseData { response in
            guard let data = response.data else {return}
            let dispatchGroupPhoto = DispatchGroup()
            let decoder = JSONDecoder()
            let json = JSON(data)
            print(json)
            var photos: [Photos2] = []
            let photosArray = json["response"]["items"].arrayValue
            print(photosArray[0])
            for (index, item) in photosArray.enumerated() {
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroupPhoto) {
                    do {
                        let photoItem = try decoder.decode(Photos2.self, from: item.rawData())
                        photos.append(photoItem)
                       
                    } catch (let errorDecode) {
                        print("error = \(errorDecode.localizedDescription) at index: \(index)")
                    }
                }
            }
            
        //    let photos3 = items.map { Photos2(json: $0) }
            dispatchGroupPhoto.notify(queue: DispatchQueue.main){
                completion(photos)
      
            }
        }
       
    }
    func APINewsRequest (completion: @escaping (NewsRequest) -> Void) {
        let session = URLSession(configuration: .default)
        let path = method + newsExtraPath
        var urlConstractor = URLComponents()
        
        urlConstractor.scheme = "https"
        urlConstractor.host = "api.vk.com"
        urlConstractor.path = path
        urlConstractor.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "access_token", value: apiKey),
//            URLQueryItem(name: "owner_id", value: userId),
            URLQueryItem(name: "v", value: "5.130"),
        ]
        
        guard let url = urlConstractor.url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
//        NetworkLogger.log(request: request)
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
  //          NetworkLogger.log(response: (response as! HTTPURLResponse), data: data, error: error)
            guard let data = data else {return}
            let decoder = JSONDecoder()
            let json = JSON(data)
            let dispatchGroup = DispatchGroup()
            
            let VKNewsItemsArray = json["response"]["items"].arrayValue
            let VKNewsGroupArray = json["response"]["groups"].arrayValue
            let VKNewsProfilesArray = json["response"]["profiles"].arrayValue
            var VKNewsItems: [NewsItem] = []
            var VKNewsProfiles: [Profile] = []
            var VKNewsGroup: [Group] = []
            
            for (index, news) in VKNewsItemsArray.enumerated() {
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    do {
                        let VKNewsItem = try decoder.decode(NewsItem.self, from: news.rawData())
                        VKNewsItems.append(VKNewsItem)
                    } catch (let errorDecode){
                        print ("error decode at index \(index) in newsItem: \(news) - error: \(errorDecode)")
                    }
                }
            }
            for (index, group) in VKNewsGroupArray.enumerated() {
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    do {
                        let VKNewsGroupDecode = try decoder.decode(Group.self, from: group.rawData())
                        VKNewsGroup.append(VKNewsGroupDecode)
                    } catch (let errorDecode){
                        print ("error decode at index \(index) in newsGroup: \(group) - error: \(errorDecode)")
                    }
                }
            }
            for (index, profile) in VKNewsProfilesArray.enumerated() {
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    do {
                        let VKNewsProfileDecode = try decoder.decode(Profile.self, from: profile.rawData())
                        VKNewsProfiles.append(VKNewsProfileDecode)
                    } catch (let errorDecode){
                        print ("error decode at index \(index) in newsGroup: \(profile) - error: \(errorDecode)")
                    }
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main){
                let response = NewsResponse (items: VKNewsItems, groups: VKNewsGroup, profiles: VKNewsProfiles)
                let feed = NewsRequest(response: response)
                completion(feed)
            }
            
        
        })
        task.resume()
    }
}
