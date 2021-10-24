//
//  Post.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 23/10/21.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
