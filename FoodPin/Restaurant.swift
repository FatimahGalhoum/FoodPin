//
//  Restaurant.swift
//  FoodPin
//
//  Created by Fatimah Galhoum on 4/24/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import Foundation

class Restaurant {
    
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var phone = ""
    var rating = "" 
    var isVisited = false
    
    
    init(name: String, type: String, location: String, image: String, phone: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.isVisited = isVisited
        
        
        
        
    }
    
    
    
    
    
}
