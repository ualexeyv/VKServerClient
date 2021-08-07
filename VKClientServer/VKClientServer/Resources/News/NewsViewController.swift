//
//  NewsViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 21.07.2021.
//

import UIKit
import FirebaseAuth

class NewsViewController: UIViewController {
    var userNews: [NewsFeedModel] = []
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
        var t = 0
        for userImage in userNews[indexPath.row].url {
            print(userNews[indexPath.row].url.count)
            guard let url = URL (string: userImage) else { return cell}
            let image = converterURLtoImage(url: url)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: t, y: 0, width: 50, height: 50)
            t += 52
            tableView.addSubview(imageView)
            imageView.bringSubviewToFront(tableView)
        }
//        guard let newsImageString = userNews[indexPath.row].url.first,
//              let url = URL (string: newsImageString) else { return cell}
//        let image = converterURLtoImage(url: url)
//        cell.newsImage.image = image
        return cell
        
    }
    
    
}
