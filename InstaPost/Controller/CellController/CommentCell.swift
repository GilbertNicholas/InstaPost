//
//  CommentCell.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 24/10/21.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var commentAuthor: UILabel!
    @IBOutlet weak var commentBody: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUI(comment: Comment) {
        self.commentAuthor.text = comment.name
        self.commentBody.text = comment.body
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CommentCell", bundle: nil)
    }
}
