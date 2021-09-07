//
//  APIGroupOeration.swift
//  VKClientServer
//
//  Created by пользовтель on 31.08.2021.
//

import Foundation
import Firebase

class FetchGroupData: Operation {
    var data: Data?
    let apiKey = Session.shared.token
    override func main() {
       
        var urlConstractor = URLComponents()
        urlConstractor.scheme = "https"
        urlConstractor.host = "api.vk.com"
        urlConstractor.path = "/method/groups.get"
        urlConstractor.queryItems = [
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: apiKey),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.130"),
        ]
        
        guard let url = urlConstractor.url,
            let data = try? Data(contentsOf: url) else { return }
        self.data = data
        print(data)
    }
}

class ParseGroupData: Operation {
    var groupItems: [GroupsModel] = []
    override func main() {
        guard let fetchGroupData = dependencies.first as? FetchGroupData,
              let data = fetchGroupData.data else { return }
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
            self.groupItems = groups
            print(groups)
        } catch (let errorDecode) {
            print (errorDecode.localizedDescription)
        }
    }
}
class SaveGroupDataToFB: Operation {
    var groupsFirebase: [GroupsFB] = []
    let ref = Database.database().reference(withPath: "groups")
    override func main() {
        guard let parseGroupData = dependencies.first as? ParseGroupData else { return }
        let groupItems: [GroupsModel] = parseGroupData.groupItems
        for group in groupItems {
            let groupsFirebase = GroupsFB(groupName: group.groupName, photo50: group.photo50, id: group.id)
            let groupRef = self.ref.child(String(group.id))
            groupRef.setValue(groupsFirebase.toAnyObject())
        }
    }
}
class DisplayGroupData: Operation {
    var controller: GroupsViewController?
    let ref = Database.database().reference(withPath: "groups")
    override func main() {
        guard let saveGroupDataToFB = dependencies.first as? SaveGroupDataToFB else { return }
        self.ref.observe(.value, with: { snapshot in
            var groups: [GroupsFB] = []
                
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let group = GroupsFB(snapshot: snapshot) {
                        groups.append(group)
                    }
                }
            print(groups.count)
            self.controller?.groupsFB = groups
            self.controller?.GroupTableView.reloadData()
        })
    }
    init(_ controller: GroupsViewController) {

        self.controller = controller
    }
}
