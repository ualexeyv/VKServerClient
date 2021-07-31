//
//  UserInfoViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 31.07.2021.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {
    let apiUser = APIService()
    var fio: String = ""
    let ref = Database.database().reference(withPath: "authUsers")
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiUser.APIUsersRequest { [weak self] users in
            guard let self = self else {return}
            
            let authUser = UsersFB(firstName: users[0].firstName, lastName: users[0].lastName, id: users[0].id)
            let userRef = self.ref.child(String(authUser.id))
            userRef.setValue(authUser.toAnyObject())
            
            self.fullNameLabel.text = users[0].firstName+" "+users[0].lastName
            let avatar = users[0].photo_50
            let url = URL(string: avatar)
            let image = converterURLtoImage(url: url!)
            self.avatarImage.image = image
        }
    }
    

}
