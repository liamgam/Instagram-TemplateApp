//
//  CollectionViewCell.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/9/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CollectionViewCellMain: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var addImage: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.addImage.image = image
        }
    }

}
