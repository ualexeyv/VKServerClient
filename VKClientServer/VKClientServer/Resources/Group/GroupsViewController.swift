//
//  GroupsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 09.07.2021.
//

import UIKit

class GroupsViewController: UIViewController {
    let apiService = APIService()
    var group: [Groups] = []
    var photos: [Item] = []
    @IBOutlet weak var GroupTableView: UITableView! {
        didSet {
            GroupTableView.dataSource = self
            GroupTableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //groups of current user
  
        apiService.APIGroupsRequest() { [weak self] groups in
            guard let self = self else {return}
            self.group = groups
            DispatchQueue.main.async {
                self.GroupTableView.reloadData()
            }
        }

        
        //group search with "swift" word
     //   apiService.APIGroupsRequest() { json in
      //      print(json)
     //   }
    }

}
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupsViewCell
        let userGroup = group[indexPath.row]
        let groupName = userGroup.groupName
        let url = URL(string: userGroup.photo50) ?? URL(string: "")
        let avatarImage = converterURLtoImage(url: url!)
        cell.GroupNameLabel.text = groupName
        cell.groupAvatarImage.image = avatarImage
        return cell
    }
    
    
    
    
}
