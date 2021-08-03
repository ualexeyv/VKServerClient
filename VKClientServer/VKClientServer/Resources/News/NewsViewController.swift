//
//  NewsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 21.07.2021.
//

import UIKit
import FirebaseAuth

class NewsViewController: UIViewController {
    var userNews: [News2] = []
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
            print(news)
            
            DispatchQueue.main.async {
                self.userNews = news
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
        let text = new.text
        cell.NewsTextLabel.text = text
        let newsImageString = userNews[indexPath.row].newsImage
        guard let url = URL (string: newsImageString) else {
            let docImageString = userNews[indexPath.row].docImage
            guard let url = URL (string: docImageString) else {return cell}
            let image = converterURLtoImage(url: url)
            cell.newsImage.image = image
            return cell
            
        }
        let image = converterURLtoImage(url: url)
        cell.newsImage.image = image
        
        return cell
    }
    
    
}
