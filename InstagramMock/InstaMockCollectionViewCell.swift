//
//  InstaMockCollectionViewCell.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 2/2/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class InstaMockCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addImageInCell: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.addImageInCell.image = image
        }
    }
    
}
