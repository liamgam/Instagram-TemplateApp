//
//  CollectionViewCell.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/7/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: ImagePickerDelegate?
    
    // MARK: - outlets
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    // MARK: - actions
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        delegate?.pickImage()
    }
    
    // MARK: - properties
    var image: UIImage? {
        didSet {
            self.img.image = image
        }
    }
}
