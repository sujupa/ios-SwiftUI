//
//  Data.swift
//  DesignCode
//
//  Created by Sujay Patil on 26/12/21.
//

import SwiftUI

struct Posts: Codable, Identifiable {

    let id = UUID()
    var title: String
    var body: String
    
}

class Api {
    
    func getPosts(completion: @escaping ([Posts]) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([Posts].self, from: data)
            
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        .resume()
    }
    
}
