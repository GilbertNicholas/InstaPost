//
//  APIService.swift
//  InstaPost
//
//  Created by Gilbert Nicholas on 23/10/21.
//

import Foundation

struct APIService {
    
    func fetchAPI(type: String, onCompletion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlString = "https://jsonplaceholder.typicode.com\(type)"
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
