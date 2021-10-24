//
//  MainTableViewCell.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 23/10/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var postCompanyOwner: UILabel!
    @IBOutlet weak var postOwnerName: UILabel!

    func configureUI(postData: Post, userData: User) {
        postTitle.text = postData.title
        postBody.text = postData.body
        postCompanyOwner.text = userData.company.name
        postOwnerName.text = userData.name
    }
}
