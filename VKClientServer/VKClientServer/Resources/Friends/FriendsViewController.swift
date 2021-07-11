//
//  FriendsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit

class FriendsViewController: UIViewController {
    let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.APIRequest(extraPath: "friends.get", userId: "", searchGroup: "") { json in
            print(json)
        }
        // Do any additional setup after loading the view.
    }
    

}
