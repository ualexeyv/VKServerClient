//
//  GroupsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit

class GroupsViewController: UIViewController {
    let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //groups of current user
        apiService.APIRequest(extraPath: "groups.get", userId: "", searchGroup: "") { json in
            print(json)
        }
        //photos of a random user
        apiService.APIRequest(extraPath: "photos.getAll", userId: "7877", searchGroup: "") { json in
            print(json)
        }
        
        //group search with "swift" word
        apiService.APIRequest(extraPath: "groups.search", userId: "", searchGroup: "swift") { json in
            print(json)
        }
    }

}
