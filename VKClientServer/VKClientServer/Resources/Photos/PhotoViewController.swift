//
//  PhotoViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 15.07.2021.
//

import UIKit
import RealmSwift
import SDWebImage

class PhotoViewController: UIViewController {
    let apiService = APIService()
    var photos: [Photos2] = []
    var userId: Int = 0
//   let photoDB = PhotoDB()
    var token: NotificationToken?
    
    lazy var cachedData: NSCache <NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        return cache
    } ()
    
    @IBOutlet weak var photoCollectionView: UICollectionView! {
        didSet {
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.APIPhotosRequest(ownerId: userId){ [weak self] photos in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.photos = photos
                self.photoCollectionView.reloadData()
            }
           
      /*      for photo in photos {
                self.photos.append(photo)
               
            } */
       //     DispatchQueue.main.async {
        //        self.photos = []
        //        self.pairPhotoAndRealm()
         //       self.photos = self.photoDB.read().filter {$0.ownerId == self.userId}
       
       //     }
        }
    }
    
}
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  //      let photoSet = photos.filter {$0.id == self.userId}
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
    //    let photoSet = photos.filter {$0.id == self.userId}
        let photo = photos[indexPath.item].sizes[2].url
        guard let url = URL (string: photo) else {return cell}
        if let image = cachedData.object(forKey: url.absoluteString as NSString) {
            cell.photoImage.image = image
            
        } else {
            let imageURL = converterURLtoImage(url: url)!
            cachedData.setObject(imageURL, forKey: url.absoluteString as NSString)
            cell.photoImage.image = imageURL
            collectionView.reloadItems(at: [indexPath])
        }

        return cell
    }
/*    func pairPhotoAndRealm () {
        guard let realm = try? Realm() else {return}
        let photo = realm.objects(Photos2.self)
        token = photo.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.photoCollectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                collectionView.performBatchUpdates({
                collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
            }, completion: nil)

            case .error(let error):
                fatalError("\(error)")

            }
        }
    } */
    
}
