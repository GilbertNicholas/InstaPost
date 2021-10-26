//
//  ViewController.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 22/10/21.
//

import UIKit

class MainViewController: UITableViewController {
    
    var posts = [Post]()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPostsData()
    }
    
    private func fetchPostsData() {
        APIService.fetchAPI(urlCompletion: "/posts", linkUrl: .data) { data, resp, err in
            guard let postByte = data, err == nil else {
                return
            }
            
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: postByte)
                DispatchQueue.global().async {
                    self.fetchUser()
                }
            } catch let error {
                print("DEBUG: API ERROR \(error.localizedDescription)")
                return
            }
        }
        
    }
    
    private func fetchUser() {
        APIService.fetchAPI(urlCompletion: "/users", linkUrl: .data) { data, resp, err in
            guard let userByte = data, err == nil else {
                return
            }
            
            do {
                self.users = try JSONDecoder().decode([User].self, from: userByte)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("DEBUG: API ERROR \(error)")
                return
            }
        }
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MainTableViewCell
        
        let postData = posts[indexPath.row]
        let userData = users[postData.userId - 1]
        
        cell.configureUI(postData: postData, userData: userData)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue" {
            guard let dest = segue.destination as? PostDetailViewController else { return }
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            let post = self.posts[indexPath.row]
            
            dest.post = post
            dest.user = self.users[post.userId - 1]
        }
    }
}

