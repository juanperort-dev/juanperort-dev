//
//  FunkoCollectionViewCell.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import UIKit

class FunkoCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "FunkoCollectionViewCell"
    
    @IBOutlet weak var image: UIImageView!
    
    func setupDataCell(_ funko: FunkoCollection) {
        image.image = UIImage(named: funko.name)
    }
}

