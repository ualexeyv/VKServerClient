//
//  NewsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 21.07.2021.
//

import UIKit
import FirebaseAuth

class NewsViewController: UIViewController {
    var userNews: [NewsItem] = []
    var groupsItems: [Group] = []
    var profileItems: [Profile] = []
    let apiNews = APIService()
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.delegate = self
            newsTableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiNews.APINewsRequest() { news in
            print(news.response.items[0])
            
            DispatchQueue.main.async {
                self.userNews = news.response.items
                self.groupsItems = news.response.groups
                self.profileItems = news.response.profiles
                self.newsTableView.reloadData()
            }
        }
        
    }

}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsViewCell
        let new = userNews[indexPath.row]
        let newId = new.id
        for groupItem in groupsItems {
            if newId == -groupItem.id {
                cell.nameOfGroupOrUserLabel.text = groupItem.name
                let url = (URL (string: groupItem.photo50)!)
                let image = converterURLtoImage(url: url)
                cell.postAvatarImage.image = image
            }
        }
        for profile in profileItems {
            if newId == profile.id {
                cell.nameOfGroupOrUserLabel.text = "\(profile.firstName) \(profile.lastName)"
                let url = (URL (string: profile.photo50)!)
                let image = converterURLtoImage(url: url)
                cell.postAvatarImage.image = image
            }
        }
        let text = new.text
        cell.NewsTextLabel.text = text
        guard let photoNews = new.attachments?[0] else {return cell}
        switch photoNews.type {
        case "photo":
            guard let userImage = photoNews.photo?.sizes[0].url,
                let url = URL (string: userImage) else { return cell}
            let image = converterURLtoImage(url: url)
            cell.attachmentPhotoImage.image = image
        default:
            return cell
        }
        
        return cell
        
    }
    
    
}
