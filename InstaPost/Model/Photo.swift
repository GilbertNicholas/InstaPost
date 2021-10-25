//
//  Photo.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 25/10/21.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

struct PhotoData {
    let title: String
    let image: Data
}
