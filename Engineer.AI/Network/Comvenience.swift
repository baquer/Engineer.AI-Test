//
//  Comvenience.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

extension Client {
    
    func getUserList(_ params: [String : AnyObject], _ completion: @escaping(_ user: [User]?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(API.Url)
        
        _ = makeRequest(url, .get, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, "invalid params")
            } else if let results = results as? [String : AnyObject] {
                
                if let data = results[Keys.Data] as? [String:AnyObject], let hasMore = data[Keys.HasMore] as? Bool, let users = data[Keys.Users] as? [[String:AnyObject]] {
                    self.moreUsersPresent = hasMore
                    let userList = User.getUsers(users: users)
                    completion(userList, true, "")
                    return
                }
                
                completion(nil, true, "Could not connect to server")
            }
            return
        })
        
    }
    
}
