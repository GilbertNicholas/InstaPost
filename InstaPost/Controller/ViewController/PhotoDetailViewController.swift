//
//  PhotoDetailViewController.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 25/10/21.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupScrollView()
    }
    
    private func configureUI() {
        guard let photo = self.photo else { return }
        
        self.photoName.text = photo.title
        
        let photoIdx = String(photo.thumbnailUrl.suffix(6))
        APIService.fetchAPI(urlCompletion: "/\(photoIdx)", linkUrl: .photo) { data, resp, err in
            guard let photoByte = data, err == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.image.image = UIImage(data: photoByte)
            }
        }
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        image.center = view.center
        return image
    }
}
