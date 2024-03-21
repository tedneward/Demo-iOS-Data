//
//  Models.swift
//  SQLiteDemo
//
//  Created by Ted Neward on 3/20/24.
//

import Foundation

class Person
{
      
    var name: String = ""
    var age: Int = 0
    var id: Int = 0
      
    init(id:Int, name:String, age:Int)
    {
        self.id = id
        self.name = name
        self.age = age
    }
    
    
}


