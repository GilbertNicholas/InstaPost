//
//  AlbumCell.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 25/10/21.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var photosColView: UICollectionView!
    
    var album: Album?
    var delegate: PerformPushController?
    private var photos = [Photo]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fetchPhotos()
        configureColView()
    }
    
    func configureUI(album: Album) {
        self.album = album
        self.albumName.text = album.title
    }
    
    func configureColView() {
        self.photosColView.register(PhotoCell.nib(), forCellWithReuseIdentifier: "PhotoCell")
        self.photosColView.delegate = self
        self.photosColView.dataSource = self
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AlbumCell", bundle: nil)
    }
    
    private func fetchPhotos() {
        guard let album = self.album else { return }
        APIService.fetchAPI(urlCompletion: "/photos?albumId=\(album.id)", linkUrl: .data) { data, resp, err in
            guard let photoByte = data, err == nil else {
                return
            }
            
            do {
                self.photos = try JSONDecoder().decode([Photo].self, from: photoByte)
                DispatchQueue.main.async {
                    self.photosColView.reloadData()
                }
            } catch let error {
                print("DEBUG: API ERROR \(error)")
                return
            }
        }
    }
}

extension AlbumCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosColView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photoIdx = String(self.photos[indexPath.row].thumbnailUrl.suffix(6))
        
        APIService.fetchAPI(urlCompletion: "/\(photoIdx)", linkUrl: .photo) { data, resp, err in
            guard let userByte = data, err == nil else {
                return
            }
            
            DispatchQueue.main.async {
                cell.configureUI(photoData: userByte)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = self.photos[indexPath.row]
        if let del = self.delegate {
            del.callPushController(photo: photo)
        }
    }
}
