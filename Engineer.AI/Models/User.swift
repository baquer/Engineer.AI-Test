//
//  User.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String = ""
    var image: String = ""
    var items: [String] = []
    
    init(dictionary: [String:AnyObject]) {
        name = dictionary[Client.Keys.Name] as? String ?? ""
        image = dictionary[Client.Keys.Image] as? String ?? ""
        items = dictionary[Client.Keys.Items] as? [String] ?? []
    }
    
    static func getUsers(users: [[String:AnyObject]]) -> [User] {
        var userList = [User]()
        for user in users {
            userList.append(User(dictionary: user))
        }
        return userList
    }
    
}
