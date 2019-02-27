//
//  Item.swift
//  Todoey
//
//  Created by Shivam Sharma on 26/02/19.
//  Copyright © 2019 Shivam Sharma. All rights reserved.
//

import Foundation

class Item:Encodable,Decodable{
    var title:String = ""
    var done:Bool = false
    
}
