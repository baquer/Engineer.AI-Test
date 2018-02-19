//
//  ViewController.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var offset = 0
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsers()
    }
    
    func getUsers() {
        
        let params = [
            Client.Keys.Offset: offset,
            Client.Keys.Limit: 10
        ]
        
        Client.sharedInstance.getUserList(params as [String:AnyObject]) { (users, success, message) in
            DispatchQueue.main.async {
                if success {
                    self.users.append(users)
                }
                self.offset += 1
            }
        }
    }

}

