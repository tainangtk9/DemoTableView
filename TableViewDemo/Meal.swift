//
//  Meal.swift
//  TableViewDemo
//
//  Created by Phan Nang on 12/23/19.
//  Copyright © 2019 Phan Nang. All rights reserved.
//

import UIKit

class Meal {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
     
    init?(name: String, photo: UIImage?, rating: Int) {
//        
//        if (name.isEmpty || rating < 0)  {
//            return nil
//        }
//
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
