//
//  AlbumCell.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 25/10/21.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var albumName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AlbumCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
