//
//  ItemCollectionViewCell.swift
//  Engineer.AI
//
//  Created by Chashmeet Singh on 19/02/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import Nuke

class ItemCollectionViewCell: UICollectionViewCell {
    
    var imageString: String? {
        didSet {
            imageView.image = nil
            let url = URL(string: imageString ?? "")!
            Manager.shared.loadImage(with: url, into: imageView)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
