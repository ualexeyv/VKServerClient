//
//  FriendsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    let apiService = APIService()
    var friends: [FriendsModel] = []
    var friendsDB = FriendsDB()
    var token: NotificationToken?
    
  
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
        //    self.friends = users
            print(users)
            DispatchQueue.main.async {
                for user in users {
                    self.friendsDB.add(user)
                }
                self.pairFriendsTableAndRealm()
          
            }
        }

    }
}
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsDB.read().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendsViewCell
        let friend = friendsDB.read()[indexPath.row]
        let avatar = friend.photo50
        let url = URL (string: avatar)
        cell.fullNameLabel.text = "\(friend.firstName) \(friend.lastName)"
        cell.avaraImage.image = converterURLtoImage (url: url!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(identifier: "PhotoVC") as! PhotoViewController
        
        VC.userId = friendsDB.read()[indexPath.row].id
      
        show(VC, sender: nil)
    }
    func pairFriendsTableAndRealm () {
        guard let realm = try? Realm() else {return}
        let friends = realm.objects(FriendsModel.self)
        token = friends.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.friendsTableView else { return }
            switch changes {
            case .initial(_):
                tableView.reloadData()

            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),with: .automatic)
                tableView.endUpdates()

            case .error(let error):
                fatalError("\(error)")

            }
        }
    }
    
}
