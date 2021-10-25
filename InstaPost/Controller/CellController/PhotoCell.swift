//
//  PhotoCell.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 25/10/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(photoData: Data) {
        self.photo.image = UIImage(data: photoData)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PhotoCell", bundle: nil)
    }
}
