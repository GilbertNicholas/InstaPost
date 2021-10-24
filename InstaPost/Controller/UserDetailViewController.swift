//
//  UserDetailViewController.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 24/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var albumTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        userName.text = user?.name
        userEmail.text = user?.email
        userCompany.text = user?.company.name
        userAddress.text = user?.address.street 
    }
    
    private func configureTableView() {
        albumTableView.register(AlbumCell.nib(), forCellReuseIdentifier: "AlbumCell")
        albumTableView.delegate = self
        albumTableView.dataSource = self
    }
}

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        return cell
    }
}
