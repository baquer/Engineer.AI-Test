//
//  UserViewController.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var offset = 0
    var userList: [User] = []
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        setupView()
        getUsers()
    }
    
    func setupView() {
        title = "User List"
        
        view.addSubview(collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "userCell")
    }
    
    func getUsers() {
        
        let params = [
            Client.Keys.Offset: offset,
            Client.Keys.Limit: 10
        ]
        
        Client.sharedInstance.getUserList(params as [String:AnyObject]) { (users, success, message) in
            DispatchQueue.main.async {
                if success {
                    users!.forEach({ (user) in
                        self.userList.append(user)
                    })
                    self.collectionView.reloadData()
                    self.offset += 10
                }
            }
        }
    }
    
}

extension UserViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! UserCollectionViewCell
        let user = userList[indexPath.item]
        cell.user = user
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 60.0
        var itemsCount = userList[indexPath.item].items.count
        if itemsCount % 2 != 0 {
            height += (view.frame.width - 32)
            itemsCount -= 1
        }
        height += (((view.frame.width - 32) / 2) * CGFloat(itemsCount / 2))
        return CGSize(width: view.frame.width - 16, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item + 1 == userList.count {
            if Client.sharedInstance.moreUsersPresent {
                getUsers()
            }
        }
    }
    
}
