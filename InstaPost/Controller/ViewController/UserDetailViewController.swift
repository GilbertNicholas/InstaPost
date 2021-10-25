//
//  UserDetailViewController.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 24/10/21.
//

import UIKit

class UserDetailViewController: UIViewController, PerformPushController {
    
    var user: User?
    private var albums = [Album]()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var userDetailAddress: UILabel!
    @IBOutlet weak var albumTableView: UITableView!
    @IBOutlet weak var albumTableViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbums()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        guard let user = self.user else { return }
        
        self.userName.text = user.name
        self.userEmail.text = user.email
        self.userCompany.text = user.company.name
        self.userAddress.text = "\(user.address.street), \(user.address.city)"
        self.userDetailAddress.text = "\(user.address.suite) \(user.address.zipcode)"
    }
    
    private func configureTableView() {
        self.albumTableView.register(AlbumCell.nib(), forCellReuseIdentifier: "AlbumCell")
        self.albumTableView.delegate = self
        self.albumTableView.dataSource = self
    }
    
    private func fetchAlbums() {
        guard let user = self.user else { return }
        APIService.fetchAPI(urlCompletion: "/albums?userId=\(user.id)", linkUrl: .data) { data, resp, err in
            guard let albumByte = data, err == nil else {
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([Album].self, from: albumByte)
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
            } catch let error {
                print("DEBUG: API ERROR \(error)")
                return
            }
        }
    }
    
    func callPushController(photo: Photo) {
        let storyboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
        let destController = storyboard.instantiateViewController(withIdentifier: "PhotoDetail") as! PhotoDetailViewController
        destController.photo = photo
        
        self.navigationController?.pushViewController(destController, animated: true)
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
        cell.delegate = self
        albumTableViewHeight.constant = CGFloat(albums.count)*cell.frame.size.height
        
        return cell
    }
}
