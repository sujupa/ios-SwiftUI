//
//  CourseStore.swift
//  DesignCode
//
//  Created by Sujay Patil on 27/12/21.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "abcd1234", accessToken: "abcd1234")

func getArray(id: String, completion: @escaping ( ([Entry]) -> () )){
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        
        switch result {
            
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
            
        case .failure(let error):
            print(error)
            
        }
        
    }
}

class CouresStore: ObservableObject {
    
    @Published var courses: [Course] = courseData
    
    init(){
        getArray(id: "course") { (items) in
            
            items.forEach { (item) in
                self.courses.append(
                    Course(
                        title    : item.fields["title"] as! String,
                        subTitle : item.fields["subtitle"] as! String,
                        image    : Image("Card2"),
                        logo     : Image("Logo1"),
                        color    : Color(hue: 0.725, saturation: 0.958, brightness: 0.844),
                        show     : false
                    )
                )
            }
            
        }
    }
    
}
