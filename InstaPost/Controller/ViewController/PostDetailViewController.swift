//
//  PostDetailViewController.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 23/10/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var user: User?
    var post: Post?
    private var comments = [Comment]()
    
    @IBOutlet weak var titlePost: UILabel!
    @IBOutlet weak var usernamePost: UIButton!
    @IBOutlet weak var bodyPost: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComments()
        configureUI()
        configureTableView()
    }
    
    private func configureUI() {
        titlePost.text = post?.title
        usernamePost.setTitle("By: \(user?.name ?? "")", for: .normal)
        bodyPost.text = post?.body
    }
    
    private func configureTableView() {
        commentTableView.register(CommentCell.nib(), forCellReuseIdentifier: "CommentCell")
        commentTableView.delegate = self
        commentTableView.dataSource = self
    }
    
    private func fetchComments() {
        guard let id = self.post?.id else { return }
        
        APIService.fetchAPI(urlCompletion: "/posts/\(id)/comments", linkUrl: .data) { data, resp, err in
            guard let postByte = data, err == nil else {
                return
            }
            
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: postByte)
                DispatchQueue.main.async {
                    self.commentTableView.reloadData()
                }
            } catch let error {
                print("DEBUG: API ERROR \(error.localizedDescription)")
                return
            }
        }
    }
    
    @IBAction func postUsernameTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "userDetailSegue", sender: self)
    }
}

extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetailSegue" {
            guard let dest = segue.destination as? UserDetailViewController else { return }

            dest.user = self.user
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        let commentData = comments[indexPath.row]
        cell.configureUI(comment: commentData)
        
        return cell
    }
}

