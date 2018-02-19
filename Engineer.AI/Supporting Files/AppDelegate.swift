//
//  AppDelegate.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.01, green: 0.66, blue: 0.96, alpha: 1.0)
        UINavigationBar.appearance().tintColor = .white
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let nvc = UINavigationController(rootViewController: UserViewController())
        window?.rootViewController = nvc
        
        return true
    }

}

