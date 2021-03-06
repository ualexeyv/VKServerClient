//
//  GroupsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit
import RealmSwift
import Firebase

class GroupsViewController: UIViewController {
    let apiService = APIService()
    let groupsDB = GroupsDB()
    var group: [GroupsModel] = []
    var token: NotificationToken?
    
    let ref = Database.database().reference(withPath: "groups")
    var groupsFB = [GroupsFB]()
    
//    var photos: [PhotosModel] = []
    @IBOutlet weak var GroupTableView: UITableView! {
        didSet {
            GroupTableView.dataSource = self
            GroupTableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let operationQueue = OperationQueue()

        let fetchGroupData = FetchGroupData()
        operationQueue.addOperation(fetchGroupData)

        let parseGroupData = ParseGroupData()
        parseGroupData.addDependency(fetchGroupData)
        operationQueue.addOperation(parseGroupData)
        
        let saveGroupDataToFB = SaveGroupDataToFB()
        saveGroupDataToFB.addDependency(parseGroupData)
        operationQueue.addOperation(saveGroupDataToFB)

        let displayGroupData = DisplayGroupData(self)
        displayGroupData.addDependency(saveGroupDataToFB)
        OperationQueue.main.addOperation(displayGroupData)
        //groups of current user
  
  /*      apiService.APIGroupsRequest() { [weak self] groups in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                for group in groups {
                    self.groupsDB.add(group)
                    let groupFB = GroupsFB(groupName: group.groupName, photo50: group.photo50, id: group.id)
                    let groupRef = self.ref.child(String(group.id))
                    groupRef.setValue(groupFB.toAnyObject())
                }
             //   self.pairGroupsTableAndRealm()
                self.ref.observe(.value, with: { snapshot in
                        var groups: [GroupsFB] = []
                        
                        for child in snapshot.children {
                            if let snapshot = child as? DataSnapshot,
                               let group = GroupsFB(snapshot: snapshot) {
                                   groups.append(group)
                            }
                        }
                        
                        self.groupsFB = groups
                        self.GroupTableView.reloadData()
                })

            }
        } */

        
        //group search with "swift" word
     //   apiService.APIGroupsRequest() { json in
      //      print(json)
     //   }
    }

}
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(groupsFB.count)
        return groupsFB.count
    //    return groupsDB.read().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupsViewCell
        let userGroup = groupsFB[indexPath.row]
        let groupName = userGroup.groupName
        let url = URL(string: userGroup.photo50) ?? URL(string: "")
        let avatarImage = converterURLtoImage(url: url!)
        cell.GroupNameLabel.text = groupName
        cell.groupAvatarImage.image = avatarImage
        return cell
    }
    func pairGroupsTableAndRealm () {
        guard let realm = try? Realm() else {return}
        let groups = realm.objects(GroupsModel.self)
        token = groups.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.GroupTableView else { return }
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
