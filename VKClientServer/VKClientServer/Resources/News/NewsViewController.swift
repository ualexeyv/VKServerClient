//
//  NewsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 21.07.2021.
//

import UIKit
import FirebaseAuth
import AVKit

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
        let nib = UINib(nibName: "NewsPhotoTableViewCell", bundle: nil)
        self.newsTableView.register(nib, forCellReuseIdentifier: "NewsPhotoCell")
        self.newsTableView.register(UINib(nibName: "NewsTextViewCell", bundle: nil), forCellReuseIdentifier: "textCell")
        self.newsTableView.register(UINib(nibName: "NewsNameViewCell", bundle: nil), forCellReuseIdentifier: "ownerCell")
        self.newsTableView.register(UINib(nibName: "NewsPhotoViewCell", bundle: nil), forCellReuseIdentifier: "NewsPhotoCell")
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return userNews.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = userNews[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ownerCell") as! NewsNameViewCell
            let newId = new.id
            for groupItem in groupsItems {
                if newId == -groupItem.id {
                    cell.nameOfGroupOrUserLabel.text = groupItem.name
                    let url = (URL (string: groupItem.photo50)!)
                    let image = converterURLtoImage(url: url)
                    cell.avatarImage.image = image
                }
            }
            for profile in profileItems {
                if newId == profile.id {
                    cell.nameOfGroupOrUserLabel.text = "\(profile.firstName) \(profile.lastName)"
                    let url = (URL (string: profile.photo50)!)
                    let image = converterURLtoImage(url: url)
                    cell.avatarImage.image = image
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! NewsTextViewCell
            let text = new.text
            cell.newsTextLabel.text = text
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPhotoCell") as! NewsPhotoViewCell
            guard let photoNews = new.attachments?[0] else {return cell}
            guard let userImage = photoNews.photo?.sizes[0].url,
                let url = URL (string: userImage) else { return cell}
            let image = converterURLtoImage(url: url)
            cell.newsPhotoImage.image = image
            return cell
        }
    }
    
}
