//
//  DataStore.swift
//  DesignCode
//
//  Created by Sujay Patil on 26/12/21.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    
    @Published var posts: [Posts] = []
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
    
}
