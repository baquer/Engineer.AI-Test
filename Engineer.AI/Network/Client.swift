//
//  Client.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import Alamofire

class Client: NSObject {
    
    static let sharedInstance = Client()
    var session: URLSession
    var moreUsersPresent = true
    
    private override init() {
        session = URLSession.shared
    }
    
    func makeRequest(_ url: String, _ httpMethod: HTTPMethod, _ headers: HTTPHeaders, parameters: [String:AnyObject], completion: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        func sendError(_ error: String) {
            debugPrint(error)
            let userInfo = [NSLocalizedDescriptionKey: error]
            completion(nil, NSError(domain: "makeRequestMethod", code: 1, userInfo: userInfo))
        }
        
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: URLEncoding(destination: .methodDependent), headers: headers).validate().responseJSON { (response: DataResponse<Any>) in
            print(response.request?.url ?? "Error: invalid URL")
            switch(response.result) {
                
            case .success(_):
                if let data = response.result.value as? Dictionary<String, Any> {
                    completion(data as AnyObject?, nil)
                } else {
                    completion(nil, NSError(domain: "Could not connect to server", code: 1))
                }
                break
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                sendError("Could not connect to server")
                break
            }
            
        }
    }
    
    // create a URL
    func getApiUrl(_ apiUrl: String, _ method: String = "") -> String {
        return "\(apiUrl)\(method)"
    }
    
}
