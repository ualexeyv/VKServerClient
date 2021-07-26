//
//  PhotoViewController.swift
//  VKClientServer
//
//  Created by пользовтель on 15.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    let apiService = APIService()
    var photos: [Photos2] = []
    var photos2: [Photos2] = []
    var userId: Int = 0
    let photoDB = PhotoDB()
    
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
            
            self.photos = photos
        //    for photo in photos {
        //        self.photoDB.add(photo)
               
       //     }
            DispatchQueue.main.async {
       //         self.photos = self.photoDB.read()
                
                self.photoCollectionView.reloadData()
            }
        }
    }
  
}
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(photos.count)
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        print(photos[indexPath.item])
        let photo = (photos[indexPath.item].sizes.first?.url)!
        let url = URL (string: photo)
        let image = converterURLtoImage(url: url!)
        cell.photoImage.image = image
        return cell
    }
    
    
}
