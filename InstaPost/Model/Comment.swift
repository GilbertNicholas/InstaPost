//
//  Comment.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 24/10/21.
//

import Foundation

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
