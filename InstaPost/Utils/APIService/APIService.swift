//
//  APIService.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 23/10/21.
//

import Foundation

enum urlType: String {
    case data = "https://jsonplaceholder.typicode.com"
    case photo = "https://via.placeholder.com/150"
}

struct APIService {
    
    func fetchAPI(urlCompletion: String, linkUrl: urlType, onCompletion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlString = "\(linkUrl.rawValue)\(urlCompletion)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let error = err {
                print("DEBUG: API ERROR \(error.localizedDescription)")
                return
            }
            
            onCompletion(data, resp, err)
        }.resume()
    }
}
