//
//  UserDetailViewController.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 24/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    private var albums = [Album]()
    private let apiService = APIService()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var albumTableView: UITableView!
    @IBOutlet weak var albumTableViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbums()
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
    
    private func fetchAlbums() {
        guard let user = self.user else { return }
        apiService.fetchAPI(urlCompletion: "/albums?userId=\(user.id)", linkUrl: .data) { data, resp, err in
            guard let userByte = data, err == nil else {
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([Album].self, from: userByte)
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
            } catch let error {
                print("DEBUG: API ERROR \(error)")
                return
            }
        }
    }
}

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = albums.count
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
            
        cell.configureUI(album: albums[indexPath.row])
        albumTableViewHeight.constant = CGFloat(albums.count)*cell.frame.size.height
        
        return cell
    }
}
