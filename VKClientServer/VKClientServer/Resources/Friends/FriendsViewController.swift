//
//  FriendsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit

class FriendsViewController: UIViewController {
    let apiService = APIService()
    var friends: [User] = []
    
        
        
    
    
    @IBOutlet weak var friendsTableView: UITableView! {
        didSet {
            friendsTableView.dataSource = self
            friendsTableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        apiService.APIFriendsRequest() { [weak self] users in
            guard let self = self else {return}
            self.friends = users
            print(users)
            DispatchQueue.main.async {
                self.friendsTableView.reloadData()
            }
        }

    }
}
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendsViewCell
        let friend = friends[indexPath.row]
        let avatar = friend.photo50
        let url = URL (string: avatar)
        cell.fullNameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.avaraImage.image = converterURLtoImage (url: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(identifier: "PhotoVC") as! PhotoViewController
        
        VC.userId = friends[indexPath.row].id
      
        show(VC, sender: nil)
    }
    
    
}
