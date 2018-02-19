//
//  UserCollectionViewCell.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 18/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import Nuke

class UserCollectionViewCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            
            let url = URL(string: user?.image ?? "")!
            Manager.shared.loadImage(with: url, into: imageView)
            
//            print(user!.name, user!.items.count)
            
            itemsCollectionView.reloadData()
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 18
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "itemCell")
        cv.isScrollEnabled = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        layer.cornerRadius = 14
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(itemsCollectionView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(36)]-8-[v1]-8-|", views: imageView, nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(36)]-8-[v1]-8-|", views: nameLabel, itemsCollectionView)
        addConstraintsWithFormat(format: "V:|-8-[v0(36)]", views: imageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: itemsCollectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

extension UserCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.imageString = user?.items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let items = user?.items {
            let cvFrame = collectionView.frame
            if items.count % 2 == 0 {
                return CGSize(width: cvFrame.width / 2 - 8, height: cvFrame.width / 2 - 8)
            } else {
                if indexPath.item == 0 {
                    return CGSize(width: cvFrame.width - 8, height: cvFrame.width - 8)
                } else {
                    return CGSize(width: cvFrame.width / 2 - 8, height: cvFrame.width / 2 - 8)
                }
            }
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
}
