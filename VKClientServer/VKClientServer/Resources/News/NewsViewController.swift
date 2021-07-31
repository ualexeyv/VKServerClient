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
            self.userNews = news
            DispatchQueue.main.async {
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
        return cell
    }
    
    
}
