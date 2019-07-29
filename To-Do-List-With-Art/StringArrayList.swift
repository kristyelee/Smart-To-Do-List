//
//  ArrayList.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/29/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import Foundation

class StringArrayList {
    
    var array: [String]
    
    init(array: [String]) {
        self.array = array
    }
    
    func count() -> Int {
        return self.array.count
    }
    
    func append(_ item: String) {
        self.array.append(item)
    }
    
    func remove(at index: Int) {
        self.array.remove(at: index)
    }
    
    func get(at index: Int) -> String {
        return self.array[index]
    }
    
    func insert(_ item: String, at index: Int) {
        self.array.insert(item, at: index)
        
    }

    
    
    
    
    
}
